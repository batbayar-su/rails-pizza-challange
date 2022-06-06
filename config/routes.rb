Rails.application.routes.draw do
  resources :orders, only: [:index, :update]

  # Defines the root path route ("/")
  root 'orders#index'
end
