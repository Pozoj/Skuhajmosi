class RecipesController < InheritedResources::Base
  load_and_authorize_resource
  impressionist :actions => [:show]
  
  def index
    index! do |format|
      format.html
      format.pdf { render :pdf => collection, :filename => "#{collection.to_s}.pdf", :type => "application/pdf", :page_size => 'A4' }
    end
  end
  
  def new
    @recipe = Recipe.new
    @recipe.author = current_user
  end
  
  def by_number_of_people
    @recipes = Recipe.by_nr_of_people(params[:nr_of_people])
    render "index"
  end
  
  def show
    show! do |format|
      format.html
      format.pdf { render :pdf => resource, :filename => "#{resource.to_s}.pdf", :type => "application/pdf", :page_size => 'A4' }
    end
  end
  
  def advanced_search
    render "recipes/index"
  end
  
  protected
  
  def collection
    if params[:search].present?
      @recipes, flash.now[:notice] = Recipe.search(params)
    elsif params[:specifics].present?
      @recipes, flash.now[:notice] = Recipe.advanced_search(params)
    else
      @recipes = Recipe.all
    end
    @recipes
  end
  
end
