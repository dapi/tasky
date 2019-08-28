# frozen_string_literal: true

Bugsnag.configure do |config|
  config.api_key = Settings.server_bugsnag_api_key
  config.app_version = AppVersion.format('%M.%m.%p') # rubocop:disable Style/FormatStringToken
  config.notify_release_stages = %w[production staging]
  config.ignore_classes << ActiveRecord::RecordInvalid
  config.ignore_classes << Grape::Exceptions::ValidationErrors
  config.ignore_classes << ApiError::NotAuthenticated
  config.send_code = true
  config.send_environment = true
end

Bugsnag.before_notify_callbacks << lambda do |report|
  report.add_tab :context, request_id: Thread.current[:request_id] if Thread.current[:request_id].present?
end
