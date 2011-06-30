class IngredientsController < InheritedResources::Base
  load_and_authorize_resource
  
  protected
  
  def collection
    unless params[:search].blank?
      @ingredients, flash.now[:notice] = Ingredient.search(params)
    else
      @ingredients = Ingredient.all
    end
    @ingredients
  end
  
end
