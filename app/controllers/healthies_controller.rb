class HealthiesController < InheritedResources::Base
  load_and_authorize_resource
  
  def index
    @healthy_recipes = RecipeKind.healthy_recipes
    index!
  end
  
end