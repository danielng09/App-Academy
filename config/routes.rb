Rails.application.routes.draw do
  resources :users, only: [:create, :new, :show, :index]
  resource :session, only: [:new, :create, :destroy]

  resources :bands do
    resource :albums, only: [:new]
  end

  resources :albums, except: [:new] do
    resource :tracks, only: [:new]
  end

  resources :tracks, except: [:new]

  resources :notes, only: [:create, :destroy]

  root to: 'users#index'
end
