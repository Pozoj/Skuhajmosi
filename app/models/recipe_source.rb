class RecipeSource < ActiveRecord::Base
  belongs_to :recipe
  has_many :recipe_authors
  has_many :photos, :as => :holder, :dependent => :destroy
  
  validates_presence_of :title
end
