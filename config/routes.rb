Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "sessions#new"

  resources :templates

  resources :role_requests

  get "test", to: "test#list_users"

  resources :sessions, only: [:new, :create, :destroy]
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"

end
