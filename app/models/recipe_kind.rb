class RecipeKind < ActiveRecord::Base
  has_and_belongs_to_many :recipes
  has_many :photos, :as => :holder, :dependent => :destroy
  
  before_save :make_a_title
  
  default_scope order("name ASC")
  
  class << self
    def recipes_by_kind(recipe_kind_name)
      healthy = self.find_by_name(recipe_kind_name)
      healthy.recipes.order(:name).where(:status_id => "approved") if healthy.present?
    end
    
    def healthy_recipes
      recipes_by_kind("Zdravo")
    end
    
    def eko_recipes
      recipes_by_kind("Eko")
    end
  
    def nostalgic_recipes
      recipes_by_kind("Nostalgija")
    end
  end
  
  def to_s
    name
  end
  
  def make_a_title
    self.name = name.slice(0,1).capitalize + name.slice(1..-1)
  end
end
