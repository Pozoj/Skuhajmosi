class Recipe < ActiveRecord::Base
  has_many :ingredients, :through => :recipe_ingredient
  belongs_to :user
  validates_presence_of :name, :user
  
  def to_s
    name
  end
end
