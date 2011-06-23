class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :unit
  has_many :photos, :as => :holder, :dependent => :destroy
  
  
  validates_presence_of :recipe_id
  validates_presence_of :ingredient_id
  validates_presence_of :unit_id
  validates_presence_of :quantity
  validates_presence_of :weight_in_grams, :if => Proc.new {|recipe_ingredient| recipe_ingredient.unit and recipe_ingredient.unit.convertable == false }
  
  validates_numericality_of :quantity, :greater_than => 0
  validates_numericality_of :weight_in_grams, :if => Proc.new {|recipe_ingredient| recipe_ingredient.unit and recipe_ingredient.unit.convertable == false }, :greater_than => 0, :message => "izbrana enota ni preračunljiva, vnesite točno težo sestavine v receptu"
  
  def to_s
    ingredient
  end
  
  def info
    [ingredient, ": #{quantity} #{ unit.short_name.present? ? unit.short_name : unit.name }"]
  end
  
  def calculated_weight_in_grams
    if unit.convertable 
      (quantity / unit.denominator) * 1000
    else
      weight_in_grams
    end
  end
  
  def price
    ingredient.price_per_gram * calculated_weight_in_grams
  end
  
end
