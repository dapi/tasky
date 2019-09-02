# frozen_string_literal: true

namespace :bugsnag do
  task deploy: :environment do
    `curl -d "apiKey=#{Bugsnag.configuration.api_key}&appVersion=#{Bugsnag.configuration.app_version}&releaseStage=#{Rails.env}" https://notify.bugsnag.com/deploy`
  end
end
