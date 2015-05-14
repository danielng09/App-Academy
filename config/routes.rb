Rails.application.routes.draw do
  resources :users, only: [:create, :new, :show, :index]
  resource :session, only: [:new, :create, :destroy]
  root to: 'users#index'
end
