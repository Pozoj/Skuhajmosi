App::Application.routes.draw do
  devise_for :users, :controllers => { :sessions => "sessions" }
  resources :ingredient_groups, :units, :user_kinds, :recipe_ingredients, :ingredients, :recipes

  root :to => "recipes#index"
end
