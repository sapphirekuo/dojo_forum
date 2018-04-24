Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index" 
  resources :posts do
    resources :replies
  end
  resources :categories, only: :show
  resources :users, only: [:show, :edit, :update]

  namespace :admin do
    root "categories#index"
    resources :categories
    resources :users
  end
end
