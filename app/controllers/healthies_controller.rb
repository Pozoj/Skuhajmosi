class HealthiesController < InheritedResources::Base
  load_and_authorize_resource
  
  def index
    healthy_recipes = RecipeKind.healthy_recipes
    @healthy_recipes = healthy_recipes.present? ? healthy_recipes.page(params[:recipe_page]) : []
    index!
  end
  
  private
  
  def collection
    @healthies = Healthy.page(params[:post_page])
  end
end