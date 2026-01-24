Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "menu#main"

  resources :sessions, only: [:new, :create]
  get "/sessions/destroy", to: "sessions#destroy"

  resources :members
  get "/qr/:id", to: "member_confimation#qr", as: :qr

end
