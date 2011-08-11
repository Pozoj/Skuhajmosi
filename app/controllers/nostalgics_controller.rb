class NostalgicsController < InheritedResources::Base
  load_and_authorize_resource
  
  def index
    nostalgic_recipes = RecipeKind.nostalgic_recipes
    @nostalgic_recipes = nostalgic_recipes.present? ? nostalgic_recipes.page(params[:recipe_page]) : []
    index!
  end
  
  private
  
  def collection
    @nostalgics = Nostalgic.page(params[:post_page])
  end
end