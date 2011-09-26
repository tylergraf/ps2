Auth::Application.routes.draw do
  get "public/index"
  get "public/mobile"
  get "public/month"
  get "check_ins/get_checkin"
  get "check_ins/hidden_form"

  resources :check_ins
  resources :public

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  root :to => "public#month"
  resources :users
  resources :sessions
  get "secret" => "secret#index"
end
