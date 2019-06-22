# frozen_string_literal: true

lock '3.11.0'

set :user, 'wwwuser'

set :repo_url, 'git@github.com:BrandyMint/tasky.git' if ENV['USE_LOCAL_REPO'].nil?
set :keep_releases, 10

set :linked_files, %w[config/database.yml config/master.key]
set :linked_dirs, %w[log node_modules tmp/pids tmp/cache tmp/sockets public/assets public/packs]

set :config_files, fetch(:linked_files)

set :app_version, AppVersion.format('%M.%m.%p') # rubocop:disable Style/FormatStringToken

set :deploy_to, -> { "/home/#{fetch(:user)}/#{fetch(:application)}" }

ask :branch, ENV['BRANCH'] || proc { `git rev-parse --abbrev-ref HEAD`.chomp } if ENV['BRANCH']

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip

set :assets_dependencies,
    %w[
      app/assets lib/assets vendor/assets app/javascript
      yarn.lock Gemfile.lock config/routes.rb config/initializers/assets.rb
      .semver
    ]

set :local_assets_dir, 'public'

set :puma_init_active_record, true

set :db_local_clean, false
set :db_remote_clean, true

set :sidekiq_processes, 3
set :sidekiq_options_per_process, ['--queue critical', '--queue critical --queue default', '--queue critical --queue mailers']

# set :bugsnag_api_key, Settings.bugsnag_api_key
