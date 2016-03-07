Rails.application.routes.draw do
  root to: 'refund_requests#index'

  devise_for :users

  resources :users, only: [:index]

  resources :refund_requests, only: [:index, :show, :update, :new, :create, :destroy]

  resources :categories, only: [:index, :edit, :update, :new, :create, :destroy]

end
