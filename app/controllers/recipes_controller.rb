class RecipesController < InheritedResources::Base
  load_and_authorize_resource
  skip_load_resource :only => [:advanced_search]
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
      @recipes = Recipe.search(params[:search])
    elsif params[:specifics].present?
      @recipes = Recipe.advanced_search(params)
    else
      @recipes = Recipe.all
    end
  end
  
end
