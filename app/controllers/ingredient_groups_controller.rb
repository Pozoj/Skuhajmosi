class IngredientGroupsController < InheritedResources::Base
  load_and_authorize_resource
  
  def show
    @recipes_for_ingredient_groups = Recipe.for_ingredient_group(params[:ingredeint_group_id])
    !show
  end
end
