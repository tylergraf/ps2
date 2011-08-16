Auth::Application.routes.draw do
  get "public/index"

  get "public/mobile"
  get "check_ins/get_checkin"

  resources :check_ins
  resources :public

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  root :to => "users#new"
  resources :users
  resources :sessions
  get "secret" => "secret#index"
end
