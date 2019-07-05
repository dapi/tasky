# frozen_string_literal: true

CarrierWave.configure do |config|
  if Rails.env.test?
    config.storage :file
  elsif Rails.env.production? || ENV['ALLOW_AWS']
    config.storage :aws
    config.aws_bucket = ENV['AWS_BUCKET'] || Rails.application.credentials.aws[:bucket]
    config.aws_credentials = {
      access_key_id: ENV['AWS_ACCESS_KEY_ID'] || Rails.application.credentials.aws[:access_key_id],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] || Rails.application.credentials.aws[:secret_access_key],
      region: ENV['AWS_DEFAULT_REGION'] || Rails.application.credentials.aws[:region]
    }

    config.aws_acl = 'public-read'

    # The maximum period for authenticated_urls is only 7 days.
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

    # Set custom options such as cache control to leverage browser caching
    config.aws_attributes = {
      cache_control: 'public, max-age=31536000'
    }
  else
    config.storage :file
  end
end
