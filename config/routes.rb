App::Application.routes.draw do
  devise_for :users

  resources :recipe_ingredients

  resources :ingredients

  resources :recipes

  root :to => "recipes#index"
end
