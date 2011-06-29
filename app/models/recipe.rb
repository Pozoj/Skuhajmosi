class Recipe < ActiveRecord::Base
  is_impressionable
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
  has_one :recipe_source
  has_many :recipe_ingredients
  has_many :ingredients, :through => :recipe_ingredients
  has_many :photos, :as => :holder, :dependent => :destroy
  has_and_belongs_to_many :recipe_kinds
  has_many :recipe_wines
  has_many :wines, :through => :recipe_wines
  
  validates_presence_of :name, :author
  validates_numericality_of :num_people, :greater_than_or_equal_to => 1, :only_integer => true
  validates_numericality_of :time_to_prepare, :only_integer => true, :if => Proc.new { |recipe| not recipe.time_to_prepare.nil? }
  validates_numericality_of :time_to_cook, :only_integer => true, :if => Proc.new { |recipe| not recipe.time_to_cook.nil? }
  
  default_scope order("name ASC")
  
  class << self
    def by_nr_of_people(nr_of_people)
      where(:num_people => nr_of_people)
    end
    
    def search(search)
      if search #for recipes
        recipe_query = self.where('name LIKE ?', "%#{search}%")
        if recipe_query.any?
          recipe_query
        else #search for ingredient, return recipes ingredients
          Ingredient.recipes_by_ingredient_search(search)
        end
      else
        scoped
      end
    end
    
    def advanced_search(params)
      nr_of_people, min_price, max_price, min_kcal, max_kcal = self.load_params_for_advanced_search(params)
      query = self.scoped
      query = query.by_nr_of_people(nr_of_people) if nr_of_people > 0
      query = query.where(:id => self.ids_between_values(min_price, max_price, { :subject => :price })) if min_price > 0 or max_price > 0
      query = query.where(:id => self.ids_between_values(min_kcal,  max_kcal,  { :subject => :kcal  })) if min_kcal  > 0 or max_kcal  > 0
      query
    end
    
    def load_params_for_advanced_search(params)
      if params[:specifics].present?
        [params[:specifics][:nr_of_people].to_i, BigDecimal(params[:specifics][:min_price]), BigDecimal(params[:specifics][:max_price]), BigDecimal(params[:specifics][:min_kcal]), BigDecimal(params[:specifics][:max_kcal])]
      else
        [0, BigDecimal("0"), BigDecimal("0"), BigDecimal("0"), BigDecimal("0")]
      end
    end
    
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
  end
  
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
  
  def calculated_price
    recipe_ingredients.map(&:price).sum
  end
  
  def to_s
    name
  end
end
