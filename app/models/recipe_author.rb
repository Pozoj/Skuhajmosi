class RecipeAuthor < ActiveRecord::Base
  has_many :recipe_sources
  has_many :recipe_source_kinds, :through => :recipe_sources
  has_many :recipes, :through => :recipe_sources
  has_many  :photos, :as => :holder, :dependent => :destroy
  validates_presence_of :first_name, :last_name
  
  def full_name
    first_name + ' ' + last_name
  end
  
  def to_s
    full_name
  end
end
