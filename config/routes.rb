# frozen_string_literal: true

require 'sidekiq/web'
require 'route_constraints'
require 'account_constraint'

Rails.application.routes.draw do
  default_url_options Settings.default_url_options.symbolize_keys

  concern :archivable do
    member do
      delete :archive
      post :restore
    end
  end

  scope subdomain: '', constraints: { subdomain: '' } do
    mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development? || Rails.env.staging?

    get '/sidekiq-stats' => proc { [200, { 'Content-Type' => 'text/plain' }, [Sidekiq::Stats.new.to_json]] }
    Sidekiq::Web.set :session_secret, Rails.application.credentials.secret_key_base
    mount Sidekiq::Web => '/sidekiq' # , constraints: RouteConstraints::AdminRequiredConstraint.new

    root to: 'welcome#index'

    resources :board_invites, only: [] do
      member do
        get :accept
      end
    end

    resources :sessions, only: %i[new create] do
      collection do
        delete :destroy
      end
    end

    resources :accounts

    resources :users, only: %i[new create]

    resource :profile, only: %i[show update], controller: :profile
    resources :password_resets, only: %i[new create edit update]
  end

  scope constraints: AccountConstraint do
    mount Public::API => '/api/'
    root to: 'boards#index', as: :account_root
    resources :cards, only: %i[show edit update] do
      concerns :archivable
    end
    resources :boards do
      concerns :archivable
      resources :members, controller: :board_members
      resources :invites, controller: :board_invites
    end
  end

  scope subdomain: 'api', as: :api, constraints: { subdomain: 'api' } do
    root controller: :swagger, action: :index, as: :doc # , constraints: { format: :html }
    mount Public::API => '/'
  end
end
