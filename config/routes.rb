Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "sessions#new"

  resources :templates

  resources :role_requests
  post "role_request/approve/:role_request_id", to: "role_requests#approve", as: "approve_request"
  post "role_request/reject/:role_request_id", to: "role_requests#reject", as: "reject_request"

  get "test", to: "test#list_users"
  get "test2", to: "test#list_roles"
  get "undo_demo", to: "test#clear_employee1"

  resources :sessions, only: [:new, :create, :destroy]
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"

end
