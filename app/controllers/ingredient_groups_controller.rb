class IngredientGroupsController < InheritedResources::Base
  load_and_authorize_resource
  
  def show
    @recipes_for_ingredient_groups = nil #Recipe.for_ingredient_group(params[:id])
    !show
  end
end
