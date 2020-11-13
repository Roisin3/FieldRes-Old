Rails.application.routes.draw do

  root 'static#home'

  get '/signin', to: 'session#new', as: 'signin'
  get '/signup', to: 'users#new'

  post '/session', to: 'session#create', as: 'session'
  delete '/session', to: 'session#destroy'

  

  match '/auth/github/callback', to: 'session#create', via: [:get, :post]

  resources :sessions
  resources :static
  resources :users

  resources :events
    resources :requirements


end  
