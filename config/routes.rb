# frozen_string_literal: true

require 'sidekiq/web'
require 'route_constraints'

Rails.application.routes.draw do
  default_url_options Settings.default_url_options.symbolize_keys

  scope subdomain: '', constraints: { subdomain: '' } do
    mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
    get '/sidekiq-stats' => proc { [200, { 'Content-Type' => 'text/plain' }, [Sidekiq::Stats.new.to_json]] }
    Sidekiq::Web.set :session_secret, Rails.application.credentials.secret_key_base
    mount Sidekiq::Web => '/sidekiq' # , constraints: RouteConstraints::AdminRequiredConstraint.new

    root to: 'welcome#index'

    resources :sessions, only: %i[new create] do
      collection do
        delete :destroy
      end
    end

    resources :users, only: %i[new create]

    resource :profile, only: %i[show update], controller: :profile
    resources :password_resets, only: %i[new create edit update]

    resources :boards
  end

  scope subdomain: 'api', as: :api, constraints: { subdomain: 'api' } do
    root controller: :swagger, action: :index, as: :doc # , constraints: { format: :html }
    mount Public::API => '/'
  end
end
