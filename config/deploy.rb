# frozen_string_literal: true

lock '3.11.2'

set :user, 'wwwuser'

set :repo_url, 'git@github.com:BrandyMint/tasky.git' if ENV['USE_LOCAL_REPO'].nil?
set :keep_releases, 10

set :linked_files, %w[config/database.yml config/master.key]
set :linked_dirs, %w[log node_modules tmp/pids tmp/cache tmp/sockets public/assets public/packs]

set :config_files, fetch(:linked_files)

set :deploy_to, -> { "/home/#{fetch(:user)}/#{fetch(:application)}" }

if ENV['BRANCH']
  set :branch, ENV['BRANCH']
else
  ask(:branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp })
end

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip

set :nvm_node, File.read('.nvmrc').strip
set :nvm_map_bins, %w[node npm yarn rake]

set :assets_dependencies,
    %w[
      app/assets lib/assets vendor/assets app/javascript
      yarn.lock Gemfile.lock config/routes.rb config/initializers/assets.rb
      .semver
    ]

set :keep_assets, 2
set :local_assets_dir, 'public'

set :puma_init_active_record, true

set :db_local_clean, false
set :db_remote_clean, true

set :sidekiq_processes, 3
set :sidekiq_options_per_process, ['--queue critical', '--queue critical --queue default', '--queue critical --queue mailers']

set :puma_control_app, true
set :puma_threads, [8, 16]
set :puma_tag, fetch(:application)
set :puma_daemonize, false
set :puma_preload_app, false
set :puma_prune_bundler, true
set :puma_plugins, [:systemd]
set :puma_init_active_record, true
set :puma_workers, 2
set :puma_start_task, 'systemd:puma:start'
set :puma_extra_settings, %{
extra_runtime_dependencies 'puma-plugin-systemd'
lowlevel_error_handler do |e|
  Bugsnag.notify(e)
  [500, {}, ["An error has occurred"]]
end
}

set :init_system, :systemd
set :systemd_sidekiq_role, :sidekiq

after 'deploy:publishing', 'systemd:puma:reload-or-restart'
after 'deploy:publishing', 'systemd:sidekiq:reload-or-restart'
# after 'deploy:published', 'bugsnag:deploy'
