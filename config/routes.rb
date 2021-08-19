Rails.application.routes.draw do
  root 'posts#index'
  resources :posts
  resources :users, only: [:new, :create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy' 
end
