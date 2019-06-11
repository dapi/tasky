# frozen_string_literal: true

require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper

  test 'show form' do
    get new_password_reset_path
    assert_response :success
  end

  test 'unknown email' do
    email = generate :email
    assert_no_emails do
      post password_resets_path, params: { password_reset: { email: email } }
    end
    assert_response :success
  end

  test 'existen user' do
    user = create :user
    assert_emails 1 do
      post password_resets_path, params: { password_reset: { email: user.email } }
    end
    assert_response :success
  end
end
