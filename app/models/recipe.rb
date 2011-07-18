class Recipe < ActiveRecord::Base
  is_impressionable
  #belongs_to :author, :class_name => "User", :foreign_key => "author_id"
  belongs_to :original, :class_name => "OriginalRecipe", :foreign_key => "original_id"
  has_one :recipe_source
  has_many :recipe_ingredients
  has_many :ingredients, :through => :recipe_ingredients
  has_many :photos, :as => :holder, :dependent => :destroy
  has_and_belongs_to_many :recipe_kinds
  has_many :recipe_wines
  has_many :wines, :through => :recipe_wines
  
  validates_presence_of :name, :short_name, :num_people, :summary, :preparation, :suggestion, :time_to_prepare, :time_to_cook, :status_id
  
  validates_numericality_of :num_people, :greater_than_or_equal_to => 1, :only_integer => true
  validates_numericality_of :time_to_prepare, :only_integer => true, :if => Proc.new { |recipe| not recipe.time_to_prepare.nil? }
  validates_numericality_of :time_to_cook, :only_integer => true, :if => Proc.new { |recipe| not recipe.time_to_cook.nil? }
  
  default_scope order("name ASC")
  
  scope :treated, where(:status_id => "treated")
  scope :master_treated, where(:status_id => "master_treated")
  scope :lectored, where(:status_id => "lectored")
  scope :rejected, where(:status_id => "rejected")
  scope :approved, where(:status_id => "approved")
  
  
  FAIL_SEARCH_MESSAGE = "Žal iskanega recepta ne moremo najti. Na voljo so slednji recepti."
  NOTHING_ENTERED_MESSAGE = "Kaj iščete? Na voljo so slednji recepti."
  
  class << self
    
    # Returns [found_recipes_array, message]
    #
    def search(params)
      query = params[:search][:recipe] if params[:search][:recipe]
      if query #for recipes
        recipe_query = self.where("name LIKE ?", "%#{query}%")
        recipes_by_ingredient_query = self.by_ingredient_search(query)
        
        if recipe_query.any?
          count = recipe_query.length
          return [ recipe_query, self.build_message(count) ]
        elsif recipes_by_ingredient_query.any?
          count = recipes_by_ingredient_query.length 
          return [recipes_by_ingredient_query, self.build_message(count, query)]
        else
          return [ self.scoped, FAIL_SEARCH_MESSAGE ]
        end
      else
        return [ self.scoped, NOTHING_ENTERED_MESSAGE ]
      end
    end
    
    # Returns [found_recipes_array, message]
    #
    def advanced_search(params)
      nr_of_people, min_price, max_price, min_kcal, max_kcal = self.load_params_for_advanced_search(params)
      query = self.scoped
      query = query.by_nr_of_people(nr_of_people) if nr_of_people > 0
      query = query.where(:id => self.ids_between_values(min_price, max_price, { :subject => :price })) if min_price > 0 or max_price > 0
      query = query.where(:id => self.ids_between_values(min_kcal,  max_kcal,  { :subject => :kcal  })) if min_kcal  > 0 or max_kcal  > 0
      [ query, self.build_message(query.length) ]
    end
    
    # Returns recipes, that contain a named ingredient
    #
    def by_ingredient_search(query)
      ingredient_query = Ingredient.where('name LIKE ?', "%#{query}%")
      if ingredient_query.any?
        recipes = []
        for ingredient in ingredient_query
          recipes << ingredient.recipes
        end
        if recipes.any?
          return recipes.flatten.uniq.sort_by {|r| r.name }
        end
      end
      []
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
