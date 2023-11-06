Rails.application.routes.draw do
  devise_for :users
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'home#index'
  get 'current_troop', to: 'troops#current', as: :current_troop
  get 'not_a_member', to: 'troops#not_a_member', as: :not_a_member
  resources :troops, only: [] do
    resources :events
  end

  namespace :admin do
    get 'dashboard', to: 'dashboard#index', as: :dashboard
    resources :users
    resources :troops
    resources :memberships, only: [:index, :show, :new, :create, :destroy]
  end
end
