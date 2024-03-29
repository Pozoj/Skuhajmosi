class Recipe < ActiveRecord::Base
  is_impressionable
  belongs_to :original, :class_name => "OriginalRecipe", :foreign_key => "original_id"
  has_one   :origin, :dependent => :destroy
  has_many  :recipe_ingredients, :dependent => :destroy
  has_many  :ingredients, :through => :recipe_ingredients
  has_many  :photos, :as => :holder, :dependent => :destroy
  has_many  :recipe_wines, :dependent => :destroy
  has_many  :wines, :through => :recipe_wines
  has_and_belongs_to_many :recipe_kinds
  
  validates_presence_of :name, :short_name, :num_people, :summary, :preparation, :suggestion, :time_to_prepare, :time_to_cook, :status_id
  
  validates_numericality_of :num_people, :greater_than_or_equal_to => 1, :only_integer => true
  validates_numericality_of :time_to_prepare, :only_integer => true, :if => Proc.new { |recipe| not recipe.time_to_prepare.nil? }
  validates_numericality_of :time_to_cook, :only_integer => true, :if => Proc.new { |recipe| not recipe.time_to_cook.nil? }
  validates_length_of :summary, :maximum => 300
  
  scope :treated, where(:status_id => "treated")
  scope :master_treated, where(:status_id => "master_treated")
  scope :lectored, where(:status_id => "lectored")
  scope :rejected, where(:status_id => "rejected")
  scope :approved, where(:status_id => "approved")
  
  
  FAIL_SEARCH_MESSAGE = "Žal iskanega recepta ne moremo najti. Na voljo so slednji recepti."
  NOTHING_ENTERED_MESSAGE = "Niste vnesni ničesar. Na voljo so slednji recepti."
  
  class << self
    
    #Returns recipes, that include one or more given ingredients
    def refrigerator_search(ingredient_ids)
      select('DISTINCT recipes.*').joins(:recipe_ingredients).where('recipe_ingredients.ingredient_id' => ingredient_ids)
    end
    
    #Returns unique initials of available recipes
    def initials
      Recipe.approved.order(:short_name).collect { |recipe| recipe.short_name.chars.first.upcase }.uniq
    end
    
    # Returns recipes that include ingredients that belong to given ingredient group
    def for_ingredient_group(ingredient_group_id)
      ingredient_group = IngredientGroup.find_by_id(ingredient_group_id)
      if ingredient_group.present?
        recipe_ingredients = RecipeIngredient.where(:ingredient_id => ingredient_group.ingredient_ids )
        recipes = recipe_ingredients.collect {|ri| ri.recipe }
        return recipes.uniq
      end
      return [ self.approved, FAIL_SEARCH_MESSAGE ]
    end
    
    # Returns [found_recipes_array, message]
    #
    def search(params)
      query = params[:search][:recipe] if params[:search][:recipe]
      if query.present? #for recipes
        recipe_query = self.approved.where("name LIKE ?", "%#{query}%")
        recipes_by_ingredient_query = self.by_ingredient_search(query)
        
        if recipe_query.any?
          count = recipe_query.length
          return [ recipe_query, self.build_message(count) ]
        elsif recipes_by_ingredient_query.any? and recipes_by_ingredient_query != self.approved
          count = recipes_by_ingredient_query.length 
          return [recipes_by_ingredient_query, self.build_message(count, query)]
        else
          return [ self.approved, FAIL_SEARCH_MESSAGE ]
        end
      else
        return [ self.approved, NOTHING_ENTERED_MESSAGE ]
      end
    end
    
    # Returns [found_recipes_array, message]
    #
    def advanced_search(params)
      nr_of_people, min_price, max_price, min_kcal, max_kcal = self.load_params_for_advanced_search(params)
      query = self.approved
      query = query.where(:num_people => nr_of_people) if nr_of_people > 0
      query = query.where(:id => self.ids_between_values(min_price, max_price, { :subject => :price })) if min_price > 0 or max_price > 0
      query = query.where(:id => self.ids_between_values(min_kcal,  max_kcal,  { :subject => :kcal  })) if min_kcal  > 0 or max_kcal  > 0
      query = query.order(:name)
      [ query, self.build_message(query.length) ]
    end
    
    # Returns recipes, that contain a named ingredient
    #
    def by_ingredient_search(query)
      ingredient_query = Ingredient.where('name LIKE ?', "%#{query}%")
      if ingredient_query.any?
        return  self.approved.where(:id => ingredient_query.collect(&:recipes).flatten.uniq.collect(&:id))
      end
      return self.approved
    end

    # Returns a proper search query message
    #
    def build_message(count, query = nil)
      discovery_statement = "Našli smo #{count} #{ case count; when 1 : "recept"; when 2 : "recepta"; when 3..4 : "recepte"; else "receptov"; end }"
      if query
        discovery_statement + " po sestavini, ki v nazivu #{case count; when 1 : "vsebuje"; when 2 : "vsebujeta"; else "vsebujejo"; end} #{query}."
      else
        discovery_statement + "."
      end
    end
    
    # Returns nr_of_people, min_price, max_price, min_kcal, max_kcal from params
    #
    def load_params_for_advanced_search(params)
      if params[:specifics].present?
        [params[:specifics][:nr_of_people].to_i, BigDecimal(params[:specifics][:min_price]), BigDecimal(params[:specifics][:max_price]), BigDecimal(params[:specifics][:min_kcal]), BigDecimal(params[:specifics][:max_kcal])]
      else
        [0, BigDecimal("0"), BigDecimal("0"), BigDecimal("0"), BigDecimal("0")]
      end
    end
    
    # Returns an array of ids of recipes that either contain kcals or price between min and max value
    #
    def ids_between_values(min_value, max_value, options = {:subject => :placeholder} )
      matching_recipes = []
      if [:price, :kcal].include?(options[:subject])
        if min_value > max_value
          tmp = min_value
          min_value = max_value
          max_value = tmp
        end
      
        if options[:subject] == :price
          if min_value > 0
            matching_recipes = self.all.reject {|recipe| (min_value..max_value).include?(recipe.calculated_price) == false }
          else
            matching_recipes = self.all.reject {|recipe| recipe.calculated_price < max_value  }
          end
        else
          if min_value > 0
            matching_recipes = self.all.reject {|recipe| (min_value..max_value).include?(recipe.number_of_kcal_per_meal) == false }
          else
            matching_recipes = self.all.reject {|recipe| recipe.number_of_kcal_per_meal < max_value  }
          end
        end   
      end
      matching_recipes.collect(&:id)
    end
    
    # Searches for recipes by number of people
    #
    def by_nr_of_people(nr_of_people)
      recipes_by_nr_of_people = where(:num_people => nr_of_people).order(:name)
      [ recipes_by_nr_of_people, self.build_message(recipes_by_nr_of_people.size) ] 
    end
    
    
    def original_ids
      unscoped.select("DISTINCT original_id").where("original_id > 0").map &:original_id
    end
    
  end #class << self
  
  def approved?
    RecipeStatus.find(status_id).approved?
  end
  
  def photos_added?
    photos.any? or (original.present? and original.photos.any?)
  end
  
  def pic
    if photos.any?
      return photos.order(:id).last
    elsif (original.present? and original.photos.any?)
      return original.photos.order(:id).last
    end
  end
  
  # Returns a RecipeStatus instance
  def status
    @status ||= RecipeStatus.find status_id
  end
  
  # Returns number of calories of a single meal
  #
  def number_of_kcal_per_meal
    kcal_per_recipe = recipe_ingredients.each.sum do |recipe_ingredient|
      calories_per_gram = recipe_ingredient.ingredient.calories / 100 
      kilograms_of_ingredient = recipe_ingredient.calculated_weight_in_grams / 1000
      (calories_per_gram * kilograms_of_ingredient)   #kcal
    end
    kcal_per_recipe / num_people
  end
  
  def calculated_ingredients
    recipe_ingredients.reject {|ri|  ri.unit.denominator.nil? or ri.ingredient.calories.nil? }.collect {|ri| ri.ingredient }
  end
  
  # Returns a calculated price of a recipe
  #
  def calculated_price
    recipe_ingredients.map(&:price).sum
  end
  
  def to_s
    name
  end
end
