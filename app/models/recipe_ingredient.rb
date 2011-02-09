class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :quantity_unit, :class_name => "Unit"
  validates_presence_of :quantity, :quantity_unit
end
