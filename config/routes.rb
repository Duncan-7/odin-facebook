Rails.application.routes.draw do
  devise_for :users
  
  root 'staticpages#home'


  resources :users

end
