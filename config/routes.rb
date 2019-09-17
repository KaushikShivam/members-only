Rails.application.routes.draw do  
  get 'posts/new', to: 'posts#new', as: 'new_post'

  post 'posts', to: 'posts#create'

  get 'posts', to: 'posts#index'
  
  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'
  
  get '/signup', to: "users#new"

  post '/signup', to: "users#create"

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "posts#index"
end
