# frozen_string_literal: true

require 'rubocop/rake_task'
RuboCop::RakeTask.new
namespace :lint do
  task i18n: :environment do
    puts 'i18n-tasks'
    system('bundle exec i18n-tasks normalize')
    puts 'normalized'
  end
  desc 'fix all linting warnings'
  task fix: ['rubocop:auto_correct', :i18n]
end
