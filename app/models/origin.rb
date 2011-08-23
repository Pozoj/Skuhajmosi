class Origin < ActiveRecord::Base
  belongs_to :recipe_source
  belongs_to :recipe
  
  def to_s
    "#{recipe_source.recipe_author}, #{recipe_source.recipe_source_kind}" if recipe_source.recipe_author.present? and recipe_source.recipe_source_kind.present?
  end
end
