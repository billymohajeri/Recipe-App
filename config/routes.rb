Rails.application.routes.draw do
  resources :foods
  devise_for :users
  
  resources :recipes do
    resources :recipe_foods
  end
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  resources :public_recipes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "foods#index"
  
  get '/recipes', to: 'recipes#index'
  get '/general_shopping_list', to: 'shoppinglists#index'
  post 'toggle_public', to: 'recipes#toggle'
  resources :shoppinglists
end
