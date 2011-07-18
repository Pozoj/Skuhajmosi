App::Application.routes.draw do
  devise_for :users, :controllers => { :sessions => "sessions" }
  
  resources :access_rights, :only => [:destroy, :edit, :update]
  
  resources :ingredient_groups, :product_firms, :products, :stores, :units, :user_kinds, :users, :vendors, :wines, :wine_groups, :wine_kinds, :wine_colors, :external_content_kinds, :externals
  
  resources :external_content_kinds do
    resources :external_contents
  end
  
  resources :external_contents
  
  resources :ingredient_groups do
    resources :photos, :only => [:new, :create]
  end

  resources :ingredients do
    resources :photos, :only => [:new, :create]
  end

  resources :original_recipes, :except => [:edit]
  
  resources :photos, :only => [:destroy]
  
  resources :products do
    resources :photos, :only => [:new, :create]
  end

  resources :recipe_kinds do
    resources :photos, :only => [:new, :create]
  end

  resources :recipes do
    resources :recipe_ingredients, :except => [:index]
    resources :recipe_wines, :except => [:index]
    resources :photos, :only => [:new, :create]
  end
    
  resources :user_kinds do
    resources :access_rights, :except => [:index, :show]
  end
  
  resources :users do
    resources :photos, :only => [:new, :create]
  end
  
  match "home/index", :to => "home#index"
  
  root :to => "home#index"
end
