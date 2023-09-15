Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :walkers, only: [:index]
  # resources :walkers do
  #   resources :availabilities, only: [:index, :create, :destroy]
  # end

  # Defines the root path route ("/")
  # root "articles#index"
end
