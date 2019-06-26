# frozen_string_literal: true

if Rails.env.development?
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
  namespace :i18n do
    task normalize: :environment do
      puts 'i18n-tasks'
      system('bundle exec i18n-tasks normalize')
      puts 'normalized'
    end
    desc 'fix all linting warnings'
  end
  task lint_fix: ['i18n:normalize', 'rubocop:auto_correct']
end
