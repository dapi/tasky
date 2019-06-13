# frozen_string_literal: true

require 'test_helper'

class BoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user create :user
  end

  test 'should get index' do
    get boards_url
    assert_response :success
  end
end
