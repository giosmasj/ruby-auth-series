Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :items, only: [:index, :create]
  post "login", to: "authentication#login"
end
