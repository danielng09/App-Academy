Rails.application.routes.draw do
  resources :users, only: [:index, :show, :update, :destroy, :create] do
    resources :contacts, only: [:index]
  end
  resources :contacts, only: [:show, :update, :destroy, :create]
  resources :contact_shares, only: [:create, :destroy]
  # get 'users/:id' => 'users#show'
  # get 'users' => 'users#index'
  # get 'users/new' => 'users#new'
  # get 'users/:id/edit' => 'users#edit'
  # post 'users' => 'users#create'
  # patch 'users/:id' => 'users#update'
  # put 'users/:id' => 'users#update'
  # delete 'users/:id' => 'users#destroy'
end
