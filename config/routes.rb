Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
      # post '/users/changepassword', to: 'user#update_password'

      resources :replies
      resources :comments
      resources :posts
      resources :categories
      resources :users
    end
    
  end
  post 'rails/active_storage/direct_uploads', to: 'direct_uploads#create'

  root :to => 'home#index'

  resources :sessions, only: [:create]
  # resources :comments
  # resources :posts
  # resources :categories
  # resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
