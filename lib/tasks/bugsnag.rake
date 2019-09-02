# frozen_string_literal: true

namespace :bugsnag do
  task deploy: :environment do
    # `curl -d "apiKey=#{Bugsnag.configuration.api_key}&appVersion=#{Bugsnag.configuration.app_version}&releaseStage=#{Rails.env}" https://notify.bugsnag.com/deploy`

    revision = Rails.root.join('REVISION')

    revision = if File.exist? revision
                 File.read(revision).chomp
               else
                 ''
               end

    `curl https://build.bugsnag.com/ \
    --header "Content-Type: application/json" \
    --data '{
      "apiKey": "#{Bugsnag.configuration.api_key}",
      "appVersion": "#{Bugsnag.configuration.app_version}",
      "releaseStage": "#{Rails.env}",
      "builderName": "robobot",
      "sourceControl": {
        "provider": "github",
        "repository": "git@github.com:BrandyMint/tasky.git",
        "revision": "#{revision}"
      },
    }'`
  end
end
