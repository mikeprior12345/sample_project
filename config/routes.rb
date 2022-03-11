Rails.application.routes.draw do
  get 'reviews/index'
  get 'reviews/show'
  get 'reviews/new'
  get 'reviews/edit'
  get 'users/index'
  resources :itemtests do
  resources :reviews
    end
  resources :items
  devise_for :users
  resources :users
  root to: "itemtests#index"
  get 'search', to: "itemtests#search"
  resources :users do
    member do
        patch :toggleadmin
        put :toggleadmin
      end
  end
  end
