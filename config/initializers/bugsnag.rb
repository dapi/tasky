# frozen_string_literal: true

require 'bugsnag/middleware/sorcery_user'

Bugsnag.configure do |config|
  config.api_key = Settings.server_bugsnag_api_key
  config.app_version = AppVersion.format('%M.%m.%p') # rubocop:disable Style/FormatStringToken
  config.notify_release_stages = %w[production staging] unless ENV['BUGSNAG_IGNORE_STAGES']
  # config.ignore_classes << ActiveRecord::RecordInvalid
  # config.ignore_classes << Grape::Exceptions::ValidationErrors
  config.ignore_classes << ApiError::NotAuthenticated
  config.send_code = true
  config.send_environment = true
  config.middleware.insert_before(Bugsnag::Middleware::Callbacks, Bugsnag::Middleware::SorceryUser) if defined?(Sorcery)
end
