Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  post '/users/:id/update', to: 'users#update'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :microposts, only: [:create, :destroy, :show, :edit]
  get  '/micropost',  to: 'microposts#show'
  get  '/rank_all',  to: 'microposts#rank_all'
  #get  '/student',  to: 'microposts#student'
  #get  '/recruit',  to: 'microposts#recruit'
  #get  '/work_rookie',  to: 'microposts#work_rookie'
  get '/sort-micropost',  to: 'microposts#index'
  get '/search_micropost',  to: 'microposts#search'
  get '/search_user',  to: 'users#search'
  resources :microposts do
    resources :likes, only: [:create, :destroy]
    resources :comments
  end
  get "users/:id/likes" => "users#likes"
  get '/microposts/hashtag/:name', to: "microposts#hashtags"
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  
end
