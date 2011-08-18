class IngredientsController < InheritedResources::Base
  load_and_authorize_resource

  respond_to :html, :json
  
  def index
    respond_to do |format|
      format.html
      format.json { render :json => Ingredient.jsonized_all.where("name like ?", "%#{params[:q]}%").map(&:attributes)}
    end
  end
  
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
