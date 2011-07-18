class HomeController < ApplicationController
  skip_authorization_check
  def index
    @top_5_recipes = Recipe.all & Popular.recipes
  end

end
