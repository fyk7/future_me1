Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  post '/users/:id/update', to: 'users#update'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'
  resources :users
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts, only: [:create, :destroy, :show]
  resources :relationships,       only: [:create, :destroy]
  get  '/micropost',  to: 'microposts#show'
  get  '/rank_all',  to: 'microposts#rank_all'
  get '/sort-micropost',  to: 'microposts#index'
  get '/search_micropost',  to: 'microposts#search'
  get '/tag_index',  to: 'microposts#tag_index'
  get '/search_user',  to: 'users#search'
  resources :microposts do
    resources :likes, only: [:create, :destroy]
    resources :comments
  end
  get "users/:id/likes", to: "users#likes"
  get '/microposts/hashtag/:name', to: "microposts#hashtags"
  resources :messages, only: [:create, :destroy]
  resources :rooms, only: [:create, :show, :index]
  
end
