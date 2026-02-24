Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "menu#main"

  resources :sessions, only: [:new, :create]
  get "/sessions/destroy", to: "sessions#destroy"

  resources :members
  resources :quotes do
    member do
      post :generate_charges
    end
  end
  resources :charges, only: [] do
    member do
      patch :pay
      patch :unpay
    end
  end
  get "/qr/:id", to: "member_confimation#qr", as: :qr

  resources :good_types
  resources :goods

end
