class IngredientGroup < ActiveRecord::Base
  validates_presence_of :name
  has_and_belongs_to_many :ingredients
  has_many :photos, :as => :holder, :dependent => :destroy
  
  default_scope order("name ASC")
  
  def to_s
    name
  end
end
