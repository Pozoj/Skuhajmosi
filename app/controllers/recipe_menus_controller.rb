class RecipeMenusController < ApplicationController
  skip_authorization_check
  skip_before_filter :authenticate_user!, :only => [:add_day_and_recipe_to_menu, :remove_recipe_from_day]
  
  def index
    load_recipes_from_cookies
  end
  
  def add_day_and_recipe_to_menu
    @recipe = Recipe.approved.find_by_id(params["id"])
    if params["day"].present? and params["id"].present? and ["mon", "tue", "wed", "thu", "fri", "sat", "sun"].include?(params["day"]) and @recipe.present?
      if cookies[params["day"]].present?
        cookies[params["day"]] = cookies[params["day"]].to_s.split(',').push(params["id"].to_s).join(',') #string of ids seperated by ','
      else
        cookies[params["day"]] = params["id"]
      end
      redirect_to recipe_menus_path, :notice => "Uspešno ste dodali #{@recipe} na Vaš tedenski jedilnik."
    else
      redirect_to recipe_menus_path, :warning => "Prišlo je do napake. Prosimo poskusite znova."
    end
  end
  
  def remove_recipe_from_day
    #1 preverim parametre
    @recipe = Recipe.approved.find_by_id(params["id"]) if params["id"].present?
    if params["day"].present? and params["position"].present? and ["mon", "tue", "wed", "thu", "fri", "sat", "sun"].include?(params["day"]) and @recipe.present?
      #2 preveri, ce je na poziciji, odstrani. 
      kukiz = cookies[params["day"]].to_s.split(',')      
      if kukiz[params[:position].to_i] == params[:id]
        kukiz.delete_at(params["position"].to_i)
        cookies[params["day"]] = kukiz.join(',')
        redirect_to recipe_menus_path, :notice => "Uspešno ste odstranili #{@recipe} iz Vašega tedenskega jedilnika."
      else
        redirect_to recipe_menus_path, :warning => "Prišlo je do napake. Prosimo poskusite znova."
      end      
    else
      redirect_to recipe_menus_path, :warning => "Prišlo je do napake. Prosimo poskusite znova."
    end
  end
  
  private 
  
  def load_recipes_from_cookies
    @recipes = []
    @daily_recipes = [[:mon, :Ponedeljek], [:tue, :Torek], [:wed, :Sreda], [:thu, :"Četrtek"], [:fri, :Petek], [:sat, :Sobota], [:sun, :Nedelja]].map do |day|
      position = -1
      hash = {}
      hash[:day] = day
      hash[:recipes] = cookies[day.first].to_s.split(',').map do |recipe_id|
        if recipe = Recipe.approved.find_by_id(recipe_id)
          position += 1
          @recipes << recipe
          {:recipe => recipe, :position => position }
        end
      end
      hash
    end.reject { |daily_hash| daily_hash[:recipes].empty? }
    parse_ingredients_and_price
   end
   
   def parse_ingredients_and_price
     @ingredients = {}
     @price = BigDecimal("0")
     @recipes.each do |recipe|
       @price += recipe.calculated_price
       recipe.recipe_ingredients.each do |ri|
         ingredient_name = ri.ingredient.name
         if @ingredients[ingredient_name].present?
           @ingredients[ingredient_name] += ri.calculated_weight_in_grams
         else
           @ingredients[ingredient_name] = ri.calculated_weight_in_grams
         end
       end
     end
   end
end