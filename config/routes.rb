Rails.application.routes.draw do

  resources :lists, only: [:index, :show, :create, :update, :destroy]
  get '/all_lists', to: 'lists#all_lists'

  resources :tasks, only: [:edit, :create, :update]

  get    '/auth/:provider/callback', to: 'sessions#create'
  delete                  '/logout', to: 'sessions#destroy'

  root 'lists#index'

end
