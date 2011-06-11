class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :unit
  has_many :photos, :as => :holder, :dependent => :destroy
  
  
  validates_presence_of :recipe_id
  validates_presence_of :ingredient_id
  validates_presence_of :unit_id
  validates_presence_of :quantity
  validates_numericality_of :quantity
  
  def to_s
    ingredient
  end
  
  def info
    [ingredient, ": #{quantity} #{unit.short_name}"]
  end
end
