# frozen_string_literal: true

require 'sidekiq'
CRONTAB_FILE = "./config/crontab_#{Rails.env}.yml"

if Rails.env.production? || Rails.env.staging? || ENV['SIDEKIQ_ASYNC']
  Sidekiq.configure_server do |config|
    config.redis = Settings.sidekiq_redis.symbolize_keys
    config.error_handlers << proc do |ex, context|
      Bugsnag.notify ex do |b|
        b.meta_data = context
      end
    end
    config.failures_max_count = 100
    config.failures_default_mode = :exhausted
  end

  Sidekiq.configure_client do |config|
    config.redis = Settings.sidekiq_redis.symbolize_keys
  end

elsif Rails.env.development?
  require 'sidekiq/testing/inline'
  Sidekiq::Testing.inline!

elsif Rails.env.test?
  require 'sidekiq/testing/inline'
  Sidekiq::Testing.fake!

  Sidekiq.configure_server do |config|
    config.redis = Settings.sidekiq_redis.symbolize_keys
  end
  Sidekiq.configure_client do |config|
    config.redis = Settings.sidekiq_redis.symbolize_keys
  end

else

  raise "Not supported env #{Rails.env}"
end

Sidekiq::Logging.logger = ActiveSupport::Logger.new Rails.root.join './log/sidekiq.log'
Sidekiq.default_worker_options = { 'backtrace' => true }

unless Rails.env.test? || Rails.env.development?
  if File.exist? CRONTAB_FILE
    Sidekiq::Cron::Job.destroy_all!
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(CRONTAB_FILE)
  end
end
