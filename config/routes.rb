App::Application.routes.draw do
  devise_for :users, :controllers => { :sessions => "sessions" }
  
  resources :access_rights, :except => [:index, :show, :edit]
  
  resources :externals do
    member do
      get :destroy_photo
    end
  end
  
  resources :external_content_kinds, :helpsters, :product_firms, :recipe_sources, :stores, :units, :user_kinds, 
            :vendors, :wine_groups, :wine_kinds, :wine_colors
  
  resources :abouts,    :except => [:show]
  resources :conditions,:except => [:show]
  resources :contacts,  :except => [:show]
  
  resources :cooks, :cooking_schools, :ekos, :events, :healthies, :know_its, :ingredient_groups, 
            :recipe_authors, :recipe_source_kinds, :ingredients, :nostalgics, :products, 
            :recipe_kinds, :table_covers, :tools, :users, :wines  do
    resources :photos, :only => [:new, :create]
  end
  
  resources :external_content_kinds do
    resources :external_contents
  end
  
  resources :external_contents
  
  resources :comments, :except => [:edit]
  resources :original_recipes, :except => [:edit]
  
  resources :photos, :only => [:destroy]
  
  resources :recipes do
    resources :recipe_ingredients, :except => [:index]
    resources :recipe_wines, :except => [:index]
    resources :origins, :except => [:index]
    resources :photos, :only => [:new, :create]
    collection do
      get :manage
      get :refrigerator_search
    end
  end
  
  resources :recipe_menus, :only => [:index] do 
    member do 
      get :add_day_and_recipe_to_menu
    end
  end
  
  
  resources :vendings, :only => [:index, :create] do 
    member do 
      get :finish_up
    end
  end
  
  match "home/index", :to => "home#index"
  root :to => "home#index"
end
