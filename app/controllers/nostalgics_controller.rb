class NostalgicsController < InheritedResources::Base
  load_and_authorize_resource
  
  def index
    @nostalgic_recipes = RecipeKind.nostalgic_recipes
    index!
  end
end