class RecipesController < InheritedResources::Base
  load_and_authorize_resource
  
  def new
    @recipe = Recipe.new
    @recipe.user = current_user
  end
end
