class HomeController < ApplicationController
  skip_authorization_check :only => [:index, :refrigerator_search]
  def index
    @top_5_recipes = Recipe.approved.merge Popular.recipes
  end

  def refrigerator_search
    
  end

end
