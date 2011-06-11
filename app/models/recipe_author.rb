class RecipeAuthor < ActiveRecord::Base
  belongs_to :recipe_source
  has_many :photos, :as => :holder, :dependent => :destroy
  
  validates_presence_of :first_name, :last_name
end
