class RecipeSourcesController < InheritedResources::Base
  load_and_authorize_resource
  
  def create
    create! { recipe_sources_path }
  end
  
  def update
    update! { recipe_sources_path }
  end
  
  def destroy
    destroy! { recipe_sources_path }
  end
end