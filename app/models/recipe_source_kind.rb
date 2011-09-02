class RecipeSourceKind < ActiveRecord::Base
  has_many :recipe_sources,  :dependent => :destroy
  has_many :recipe_authors, :through => :recipe_sources
  has_many  :photos, :as => :holder, :dependent => :destroy
  validates_presence_of :title, :description
  
  def recipes
    Recipe.where(:id => Origin.where(:recipe_source_id => recipe_source_ids).map(&:recipe_id) )
  end
  
  def to_s
    title
  end
end