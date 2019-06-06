# frozen_string_literal: true

require 'test_helper'

class BoardsControllerTest < ActionDispatch::IntegrationTest
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller

  def login_user(user)
    post sessions_path, params: { user_session: { login: user.email, password: 'password' } }
    follow_redirect!
  end

  setup do
    login_user create :user
  end

  test 'should get index' do
    get boards_url
    assert_response :success
  end
end
