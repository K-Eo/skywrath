Rails.application.routes.draw do
  resource :dashboard, only: :show, controller: 'dashboard'

  devise_for :users, path: 'sudo', controllers: {
    registrations: 'users/registrations'
  }

  root to: 'pages#index'

  get '*unmatched_route', to: 'application#route_not_found'
end
