class Unit < ActiveRecord::Base
  has_many :products
  has_many :recipe_ingredients
  validates_presence_of :name
  validates_presence_of :denominator, :if => Proc.new {|unit| unit.convertable == true }
  validates_numericality_of :denominator, :if => Proc.new {|unit| unit.convertable == true }
  
  def to_s
    name
  end
end
