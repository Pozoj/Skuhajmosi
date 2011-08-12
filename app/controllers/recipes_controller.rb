class RecipesController < InheritedResources::Base
  load_and_authorize_resource
  impressionist :actions => [:show]
  
  helper_method :sort_column, :sort_direction, :pick, :recipe_kind
  
  def index
    @initials = Recipe.initials
    # index! do |format|
    #   format.html
    #   format.pdf #{ render :pdf => collection, :filename => "#{collection.to_s}.pdf", :type => "application/pdf", :page_size => 'A4' }
    # end
  end
  
  def manage
    @treated_count = Recipe.treated.length
    @master_treated_count = Recipe.master_treated.length
    @lectored_count = Recipe.lectored.length
    @rejected_count = Recipe.rejected.length
    @approved_count = Recipe.approved.length
    if recipe_kind
      @recipes = RecipeKind.find_by_id(recipe_kind).recipes.where(:status_id => pick).order(sort_column + " " + sort_direction)
    else
      @recipes = Recipe.where(:status_id => pick).order(sort_column + " " + sort_direction)
    end
    @recipe_kinds = RecipeKind.all
  end
  
  def new
    @recipe = Recipe.new
    append_original_recipe
  end
  
  def by_number_of_people
    @recipes = Recipe.by_nr_of_people(params[:nr_of_people])
    render "index"
  end
  
  def show
    @recipe_info = RecipeInfo.new(params) #app/presenters/recipe_info.rb
    
    respond_to do |format|
      format.html
      format.pdf #{ render :pdf => @recipe_info.recipe, :filename => "recept.pdf", :type => "application/pdf", :page_size => 'A4' }
    end
  end
  
  def advanced_search
    render "recipes/index"
  end
  
  protected
  
  def append_original_recipe
    @recipe.original = OriginalRecipe.find_by_id(params[:original_id]) if params[:original_id]
    if og = @recipe.original
      @recipe.name        = og.name
      @recipe.num_people  = og.num_people
      @recipe.summary     = og.summary
      @recipe.preparation = og.preparation
      @recipe.suggestion  = og.suggestion
    end
  end
  
  def collection
    if params[:initial].present?
      if Recipe.initials.include?(params[:initial])
        @recipes = Recipe.approved.where("short_name LIKE ?", "#{params[:initial]}%").order(:short_name).page(params[:recipe_page])
      else 
        @recipes = Recipe.approved.page(params[:recipe_page])
      end
    elsif params[:nr_of_people].present?
      @recipes, flash.now[:notice] = Recipe.by_nr_of_people(params[:nr_of_people])
      @recipes = @recipes.page(params[:recipe_page])
    elsif params[:search].present?
      @recipes, flash.now[:notice] = Recipe.search(params)
      @recipes = @recipes.page(params[:recipe_page])
    elsif params[:specifics].present?
      @recipes, flash.now[:notice] = Recipe.advanced_search(params)
      @recipes = @recipes.page(params[:recipe_page])
    else
      @recipes = Recipe.approved.order(:short_name).page(params[:recipe_page])
    end
    @recipes
  end
  
  private

  def recipe_kind
    return params[:recipe_kind] if (RecipeKind.all.collect(&:id)).include?(Integer(params[:recipe_kind])) 
  end
  
  def pick
    RecipeStatus.keys.include?(params[:pick]) ? params[:pick] : "treated"
  end
  
  def sort_column
    Recipe.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
