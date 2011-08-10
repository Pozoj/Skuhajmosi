class EkosController < InheritedResources::Base
  load_and_authorize_resource
  
  def index
    @eko_recipes = RecipeKind.eko_recipes
    index!
  end
end