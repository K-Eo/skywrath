Rails.application.routes.draw do
  devise_for :users, path: 'sudo', controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'

  get '*unmatched_route', to: 'application#route_not_found'
end
