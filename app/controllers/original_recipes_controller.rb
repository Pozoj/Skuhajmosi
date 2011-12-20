class OriginalRecipesController < InheritedResources::Base
  load_and_authorize_resource
  skip_load_resource :only => [:new, :create]
  skip_before_filter :authenticate_user!, :only => [:new, :create]
  
  
  def new
    @original_recipe = OriginalRecipe.new
    @original_recipe.photos.build
  end
  
  def create
    photo_attributes = params["original_recipe"]["photos_attributes"]["0"] if params["original_recipe"].present? and params["original_recipe"]["photos_attributes"].present? and params["original_recipe"]["photos_attributes"]["0"].present?
    if params["original_recipe"].present? and og_recipe = OriginalRecipe.create(params["original_recipe"].delete_if {|k,v| k == "photos_attributes"} )
      if photo_attributes.present?
        photo = Photo.create({:holder_id => og_recipe.id, :holder_type => "OriginalRecipe"}.merge(photo_attributes))
      end
      redirect_to recipes_path, :notice => "Uspešno ste oddali recept. Hvala za Vaš prispevek."
    else
      render new_original_recipe_path, :alert => "Prišlo je do napake. Poskusite jih odpraviti."
    end
  end
  
  private
  
  def collection
    OriginalRecipe.untreated
  end
  
end