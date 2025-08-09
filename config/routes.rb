Rails.application.routes.draw do
  devise_for :users
  root to: "products#index"

  resources :products do
    resources :cart_items, only: [:create]
  end

  resources :cart_items, only: [:index, :update, :destroy]
end
