Rails.application.routes.draw do

  get 'sudo/edit', to: redirect('/settings/profile')
  devise_for :users, path: 'sudo', controllers: {
    registrations: 'users/registrations'
  }

  resource :dashboard, only: :show, controller: 'dashboard'

  namespace :settings do
    resource :profile, only: [:show, :update], controller: 'profile'
    resource :account, only: [:show, :update, :destroy], controller: 'account'
  end

  root to: 'pages#index'

  get '*unmatched_route', to: 'application#route_not_found'
end
