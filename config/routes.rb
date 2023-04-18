Rails.application.routes.draw do
  resources :foods
  devise_for :users
  resources :recipes
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "foods#index"
  get '/public_recipe', to: 'recipes#public'
end
