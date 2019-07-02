# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'slim-rails'

gem 'sorcery'

gem 'grape'
gem 'grape-entity'
gem 'grape-rails-cache'
gem 'grape-swagger'
gem 'grape-swagger-entity'
gem 'semver2'
gem 'swagger-ui_rails5', github: 'yunixon/swagger-ui_rails5'

gem 'http_accept_language'

gem 'oj'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

gem 'active_link_to'
gem 'simple_form'

gem 'auto_logger'

gem 'bootstrap', '~> 4.3.1'
gem 'jquery-rails'
gem 'pagy'
gem 'popper_js'

gem 'fast_jsonapi'
gem 'react-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'best_in_place'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'nilify_blanks'
gem 'settingslogic'
gem 'valid_email'

gem 'dalli'
gem 'gravatarify'
gem 'inline_svg'
gem 'nprogress-rails'
gem 'rack-cors'

gem 'kramdown'
gem 'kramdown-parser-gfm'
gem 'kramdown-syntax-coderay'

gem 'stamp'

gem 'sidekiq'
gem 'sidekiq-failures'

gem 'dapi-archivable', require: 'archivable'
gem 'recaptcha'
gem 'request_store'

group :development, :test do
  gem 'database_rewinder'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rubocop-rails'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'factory_bot'
  gem 'factory_bot_rails'

  gem 'i18n-tasks'
end

group :development, :staging do
  gem 'letter_opener'
  gem 'letter_opener_web'
end

group :development do
  gem 'bugsnag-capistrano', require: false
  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-db-tasks', require: false
  gem 'capistrano-faster-assets', require: false
  gem 'capistrano-git-with-submodules', '~> 2.0'
  gem 'capistrano-master-key', require: false, github: 'virgoproz/capistrano-master-key'
  gem 'capistrano-rails', require: false
  gem 'capistrano-rails-console', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-shell', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'capistrano-yarn', require: false
  gem 'capistrano3-puma', github: 'seuros/capistrano-puma', require: false
  gem 'overcommit'

  gem 'foreman'
  gem 'image_optim'
  gem 'scss-lint'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'terminal-notifier-guard' # , '~> 1.6.1', require: darwin_only('terminal-notifier-guard')

  gem 'guard'

  gem 'guard-ctags-bundler'
  gem 'guard-minitest'
  gem 'guard-rubocop'
  gem 'guard-spring'
end

group :test do
  gem 'minitest-focus'
  gem 'minitest-reporters'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'bugsnag', '~> 6.11'

gem 'bootstrap_views_generator', '~> 0.1.3'
