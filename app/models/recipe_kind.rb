class RecipeKind < ActiveRecord::Base
  has_and_belongs_to_many :recipes
  has_many :photos, :as => :holder, :dependent => :destroy
  
  default_scope order("name ASC")
  
  def to_s
    name
  end
end
