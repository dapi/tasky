# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tasky
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    I18n.available_locales = %i[ru en]
    I18n.default_locale = :ru
    config.time_zone = 'Europe/Moscow'
    Time.zone = 'Europe/Moscow'

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins Settings.default_url_options.host, 'api.' + Settings.default_url_options.host
        resource '*',
                 credentials: true,
                 headers: :any,
                 methods: %i[get post options delete patch put]
      end
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
