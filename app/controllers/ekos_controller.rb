class EkosController < InheritedResources::Base
  load_and_authorize_resource
  
  def index
    eko_recipes = RecipeKind.eko_recipes
    @eko_recipes = eko_recipes.present? ? eko_recipes.page(params[:recipe_page]) : []
    index!
  end
  
  private
  
  def collection
    @ekos = Eko.page(params[:post_page])
  end
end