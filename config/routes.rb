Auth::Application.routes.draw do
  get "public/index"
  get "public/mobile"
  get "public/month"
  get "check_ins/get_checkin"
  get "check_ins/hidden_form"

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  root :to => "public#index"
  resources :users
  resources :sessions
  resources :check_ins
  resources :public
  resources :password_reset
  get "secret" => "secret#index"

  get "month" => "public#index", :as => "month"
  match "/month/:id" => "public#show"

end
