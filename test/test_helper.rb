# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require 'database_rewinder'
require './test/support/database_rewinder_support.rb'

DatabaseRewinder.clean_with :truncation
DatabaseRewinder.strategy = :transaction

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all
  include FactoryBot::Syntax::Methods
  include DatabaseRewinderSupport

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  include DatabaseRewinderSupport
end
