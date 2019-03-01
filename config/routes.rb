# Rails.application.routes.draw do
#   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#   root to: "tasks#index"
  
#   resources :tasks
# end
#   上記がもともとの記述
#   下記がレッスン12user認証のための記述

Rails.application.routes.draw do
  root to: "toppages#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get "signup", to: "users#new"
  resources :users, only: [:index, :show, :new, :create]
  
  resources :tasks
end