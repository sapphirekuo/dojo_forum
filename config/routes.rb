Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index" 
  resources :posts do
    resources :replies
    collection do
      get :feeds
    end

    member do
      post :collect
      post :uncollect
    end
  end

  resources :categories, only: :show
  resources :users, only: [:show, :edit, :update] do
    member do
      get :my_comment
      get :my_collect
      get :my_draft
      get :my_friend
    end
  end

  resources :friendships, only: [:create, :destroy]

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      
      post "/login" => "auth#login"
      post "/logout" => "auth#logout"

      resources :posts, only: [:index, :create, :show, :update, :destroy]
    end
  end

  namespace :admin do
    root "categories#index"
    resources :categories
    resources :users
  end
end
