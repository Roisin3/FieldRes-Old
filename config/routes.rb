Rails.application.routes.draw do

  resources :users

  resources :events
    resources :requirements

end  
