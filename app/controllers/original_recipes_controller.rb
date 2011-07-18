class OriginalRecipesController < InheritedResources::Base
  load_and_authorize_resource
  skip_load_resource :only => [:new, :create]
  skip_before_filter :authenticate_user!, :only => [:new, :create]
  
  
  def new
    @original_recipe = OriginalRecipe.new
    @original_recipe.photos.build
  end
  
  def create
    create!(:notice => "Uspešno ste oddali recept. Hvala za Vaš prispevek.") { recipes_path }
  end
  
  private
  
  def collection
    OriginalRecipe.untreated
  end
  
end