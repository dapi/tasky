# frozen_string_literal: true

set :application, 'tasky.online'
set :stage, :production
set :rails_env, :production
fetch(:default_env)[:rails_env] = :production

server 'helex.brandymint.ru', user: fetch(:user), port: '22', roles: %w[sidekiq web app db bugsnag].freeze
