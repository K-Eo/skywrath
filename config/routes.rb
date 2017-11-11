Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
  end
  post '/graphql', to: 'graphql#execute'
  post '/graphql/sign_in', to: 'graphql#sign_in'
  delete '/graphql/sign_out', to: 'graphql#sign_out'

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

  mount API::Root => '/'

  get 'sudo/edit', to: redirect('/settings/profile')
  devise_for :users, path: 'sudo', controllers: {
    registrations: 'users/registrations'
  }

  root to: 'pages#index'

  get '*unmatched_route', to: 'application#route_not_found'
end
