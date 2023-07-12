Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  devise_scope :user do
    delete 'logout', to: 'devise/sessions#destroy'
  end

  root 'home#index'

  resources :products, only: [:index]
  resources :cart_items, only: [:create, :destroy]
  resources :orders, only: [:create, :index]

  get 'cart', to: 'cart_items#index'
end
