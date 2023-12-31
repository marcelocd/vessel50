
Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'home#index'

  resources :trackings, only: :index do
    collection do
      get 'scrape'
    end
  end

  resources :vessels, only: %i[index show]
  resources :vessel_types, only: :index

  namespace :api do
    namespace :v1 do
      resources :trackings, only: %i[index show]
      resources :vessels, only: %i[index show]
      resources :vessel_types, only: %i[index show]
    end
  end
end
