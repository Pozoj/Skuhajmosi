class RecipeSourceKind < ActiveRecord::Base
  has_many :recipe_sources
  has_many :recipe_authors, :through => :recipe_sources
  has_many :recipes, :through => :recipe_sources
  has_many  :photos, :as => :holder, :dependent => :destroy
  validates_presence_of :title, :description
  
  def to_s
    title
  end
end