Auth::Application.routes.draw do
  resources :check_ins

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  root :to => "users#new"
  resources :users
  resources :sessions
  get "secret" => "secret#index"
end
