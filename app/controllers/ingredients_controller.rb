class IngredientsController < InheritedResources::Base
  load_and_authorize_resource
  
  protected
  
  def collection
    unless params[:search].blank?
      @ingredients = Ingredient.search(params[:search])
    else
      @ingredients = Ingredient.all
    end
  end
end
