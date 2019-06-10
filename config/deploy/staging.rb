# frozen_string_literal: true

set :application, 'tasky.brandymint.ru'
set :stage, :staging
set :rails_env, :staging
fetch(:default_env)[:rails_env] = :staging

server 'helex.brandymint.ru', user: fetch(:user), port: '22', roles: %w[sidekiq web app db bugsnag].freeze
