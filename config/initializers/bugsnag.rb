# frozen_string_literal: true

Bugsnag.configure do |config|
  config.api_key = '0596786f8ab8dbce98574ae571b7c489'
  config.app_version = AppVersion.format('%M.%m.%p') # rubocop:disable Style/FormatStringToken
  config.notify_release_stages = %w[production staging]
  config.ignore_classes << ActiveRecord::RecordInvalid
  config.send_code = true
  config.send_environment = true
end

Bugsnag.before_notify_callbacks << lambda do |report|
  report.add_tab :context, request_id: Thread.current[:request_id] if Thread.current[:request_id].present?
end
