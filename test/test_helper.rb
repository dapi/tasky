# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

require 'minitest/focus'
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Test are translactional, but somethimes it can stops immediatly and keep database dirty
DatabaseRewinder.clean_all

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller

  # Why it does not work with default Sorcery method?
  def login_user(user = nil)
    user = create :user if user.nil?
    @current_user = user
    post sessions_url, params: { user_session: { login: user.email, password: 'password' } }
    follow_redirect!
  end
end
