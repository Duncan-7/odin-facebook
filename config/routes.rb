Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations'}
  
  root 'users#index'


  resources :users
  resources :posts

  resources :friendships, only: [:create, :destroy]
  resources :friend_requests, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
end
