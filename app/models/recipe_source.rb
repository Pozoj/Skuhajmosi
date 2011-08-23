class RecipeSource < ActiveRecord::Base
  belongs_to  :recipe_source_kind
  belongs_to  :recipe_author
  has_many    :origins
  
  validates_presence_of :recipe_source_kind_id, :recipe_author_id, :message => "Mora biti izbrano."
  
  
  def to_s
    "#{recipe_author}, #{recipe_source_kind}"
  end
end
