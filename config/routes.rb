Rails.application.routes.draw do

  root 'static#home'

  get '/signin', to: 'session#new', as: 'signin'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  post '/session', to: 'session#create', as: 'session'
  delete '/session', to: 'session#destroy'

  get '/auth/facebook/callback' => 'users#omniauth'

  get '/users/:id', to: 'users#show'
  get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  patch '/users/:id', to: 'users#update'

  resources :session
  resources :static
  resources :users do
    resources :events
  end

  resources :events do
    resources :requirements
  end


end  
