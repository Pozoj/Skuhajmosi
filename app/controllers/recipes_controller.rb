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
    raise CanCan::AccessDenied unless ( @recipe_info.recipe.approved? or (current_user.present? and (current_user.admin? or (current_user.user_kind.present? and [:worker, :master_cook, :lector].include?(current_user.user_kind.id)))) )
    
    respond_to do |format|
      format.html
      format.pdf #{ render :pdf => @recipe_info.recipe, :filename => "recept.pdf", :type => "application/pdf", :page_size => 'A4' }
    end
  end
  
  def advanced_search
    render "recipes/index"
  end
    
  #########
  protected
  #########
  
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
    elsif params[:ingredient_tokens].present? and params[:ingredient_tokens][:ingredient].present?
      all_found_recipes = Recipe.approved.refrigerator_search(params[:ingredient_tokens][:ingredient])
      recipes_count = all_found_recipes.size
      ingredients_count = params[:ingredient_tokens][:ingredient].size
      @recipes = all_found_recipes.page(params[:recipe_page])
      if recipes_count > 0
        flash.now[:notice] = "Našli smo #{recipes_count} #{case recipes_count; when 1 : "recept"; when 2 : "recepta"; when 3,4 : "recepte"; else "receptov"; end}, ki #{case recipes_count; when 1 : "vsebuje"; when 2 : "vsebujeta"; else "vsebujejo"; end} #{case ingredients_count; when 1 : "navedeno sestavino"; else "eno ali več navedenih sestavin"; end}."
      else
        "Žal nismo našli nobenega recepta, ki bi vseboval #{case ingredients_count; when 1 : "navedeno sestavino"; else "eno ali več navedenih sestavin"; end}."
      end
    elsif params[:nr_of_people].present?
      @recipes, flash.now[:notice] = Recipe.by_nr_of_people(params[:nr_of_people])
      @recipes = @recipes.page(params[:recipe_page])
    elsif params[:refrigerator_search].present?
      @recipes = Recipe.refrigerator_search(params[:q])
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
  
  #######
  private
  #######
  
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
