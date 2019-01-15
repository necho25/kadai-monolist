Rails.application.routes.draw do
  get 'users/show'

  get 'users/new'

  get 'users/create'

  root to: 'toppage#index'
  
  get 'toppages/index'
  resources :user, only: [:show, :new, :create]

end
