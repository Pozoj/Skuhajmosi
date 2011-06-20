class Ingredient < ActiveRecord::Base
  has_many :products
  has_many :recipe_ingredients
  has_many :recipes, :through => :recipe_ingredients
  has_many :photos, :as => :holder, :dependent => :destroy
  has_and_belongs_to_many :ingredient_groups  
  validates_presence_of :name
  
  default_scope order("name ASC")
  
  class << self
    def search(search)
      if search #for ingredients
        ingredient_query = self.where('name LIKE ?', "%#{search}%")
        if ingredient_query.any?
          ingredient_query
        end
      else
        scoped
      end
    end
    
    def recipes_by_ingredient_search(search)
      ingredient_query = self.where('name LIKE ?', "%#{search}%")
      if ingredient_query.any?
        recipes = []
        for ingredient in ingredient_query
          recipes << ingredient.recipes
        end
        if recipes.any?
          recipes.flatten.uniq.sort_by {|r| r.name }
        else
          Recipe.scoped
        end
      else
        Recipe.scoped
      end
    end
  end
  
  def to_s
    name
  end
  
end
