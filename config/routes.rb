Rails.application.routes.draw do
  get 'cart_items/index'
  get 'cart_items/create'
  get 'cart_items/update'
  get 'cart_items/destroy'
  get 'products/index'
  get 'products/show'
  get 'products/new'
  get 'products/create'
  get 'products/edit'
  get 'products/update'
  get 'products/destroy'
  devise_for :users
  root to: "products#index"

  resources :products do
    resources :cart_items, only: [:create]
  end

  resources :cart_items, only: [:index, :update, :destroy]
end
