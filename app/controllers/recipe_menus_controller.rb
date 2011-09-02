class RecipeMenusController < ApplicationController
  skip_authorization_check
  skip_before_filter :authenticate_user!, :only => [:add_day_and_recipe_to_menu]
  
  def index
    load_recipes_from_cookies
  end
  
  def add_day_and_recipe_to_menu
    @recipe = Recipe.approved.find_by_id(params["id"])
    if params["day"].present? and params["id"].present? and ["mon", "tue", "wed", "thu", "fri", "sat", "sun"].include?(params["day"]) and @recipe.present?
      cookies[params["day"]] = params["id"]
      redirect_to recipe_menus_path, :notice => "Uspešno ste dodali #{@recipe} na Vaš tedenski jedilnik."
    else
      redirect_to recipe_menus_path, :warning => "Prišlo je do napake. Prosimo poskusite znova."
    end
  end
  
  private 
  
  def load_recipes_from_cookies
     @mon_recipe = Recipe.approved.find_by_id(cookies[:mon])
     @tue_recipe = Recipe.approved.find_by_id(cookies[:tue])
     @wed_recipe = Recipe.approved.find_by_id(cookies[:wed])
     @thu_recipe = Recipe.approved.find_by_id(cookies[:thu])
     @fri_recipe = Recipe.approved.find_by_id(cookies[:fri])
     @sat_recipe = Recipe.approved.find_by_id(cookies[:sat])
     @sun_recipe = Recipe.approved.find_by_id(cookies[:sun])
   end
end