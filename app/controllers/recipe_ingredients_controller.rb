class RecipeIngredientsController < InheritedResources::Base
  belongs_to :recipe
end
