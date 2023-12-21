Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }  
  
  get "up" => "rails/health#show", as: :rails_health_check
  root "splash#index"
  resources :splash, only: [:index]
  resources :categories

  # Rutas para 'acquisition'
  resources :acquisition, except: [:index]

  # Ruta personalizada para añadir una nueva 'acquisition'
  get 'acquisition/new/:category_id', to: 'acquisition#new', as: 'add_new_acquisition'
  post 'acquisition/create/:category_id', to: 'acquisition#create', as: 'create_new_acquisition'
end
