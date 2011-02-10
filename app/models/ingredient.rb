class Ingredient < ActiveRecord::Base
  has_many :recipes, :through => :recipe_ingredients
  has_many :recipe_ingredients
  has_and_belongs_to_many :ingredient_groups
  validates_presence_of :name
  
  def to_s
    name
  end
end
