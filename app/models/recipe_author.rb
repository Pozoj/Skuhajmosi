class RecipeAuthor < ActiveRecord::Base
  has_many :recipe_sources, :dependent => :destroy
  has_many :recipe_source_kinds, :through => :recipe_sources
  has_many :origins, :through => :recipe_sources
  has_many  :photos, :as => :holder, :dependent => :destroy
  validates_presence_of :first_name, :last_name
  
  
  def recipes
    Recipe.where(:id => Origin.where(:recipe_source_id => recipe_source_ids).map(&:recipe_id) )
  end

  
  def full_name
    first_name + ' ' + last_name
  end
  
  def to_s
    full_name
  end
end
