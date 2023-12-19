Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "splash#index"
  resources :splash, only: [:index]
  resources :categories, only: [:index, :new, :create]
  resources :acquisition, only: [:show, :create]

  get 'acquisition/new/:id', to: 'acquisition#new', as: 'add_new_acquisition'
  post 'acquisition/create/:id', to: 'acquisition#create', as: 'create_new_acquisition'
end