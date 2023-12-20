Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }  
  
  get "up" => "rails/health#show", as: :rails_health_check

  
  root "splash#index"
  resources :splash, only: [:index]
  resources :categories, only: [:index, :new, :create]
  resources :acquisition, only: [:show, :create]

  get 'acquisition/new/:id', to: 'acquisition#new', as: 'add_new_acquisition'
  post 'acquisition/create/:id', to: 'acquisition#create', as: 'create_new_acquisition'
end