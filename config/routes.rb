App::Application.routes.draw do
  resources :ingredient_groups

  resources :units

  resources :user_kinds

  devise_for :users

  resources :recipe_ingredients

  resources :ingredients

  resources :recipes

  root :to => "recipes#index"
end
