Rails.application.routes.draw do
  get '/dashboard', to: 'dashboard#root'
  resource :profile, only: :show, controller: 'users/profile'

  scope 'dashboard' do
    resources :alerts, only: [:index, :create]
  end

  namespace :settings do
    resource :account, only: [:show, :update, :destroy], controller: 'account'
    resource :email, only: [:show, :update], controller: 'email'
    resource :profile, only: [:show, :update], controller: 'profile'
  end

  get 'sudo/edit', to: redirect('/settings/profile')
  devise_for :users, path: 'sudo', controllers: {
    registrations: 'users/registrations'
  }

  root to: 'pages#index'

  get '*unmatched_route', to: 'application#route_not_found'
end
