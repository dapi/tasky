# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

use Rack::Cors do
  allow do
    origins Settings.default_url_options.host, '*.' + Settings.default_url_options.host, 'localhost'
    resource '*',
             credentials: true,
             headers: :any,
             methods: %i[get post options delete patch put]
  end

  allow do
    origins '*'
    resource '*',
             credentials: false,
             headers: :any,
             methods: %i[get post options delete patch put]
  end
end

run Rails.application
