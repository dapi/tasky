# frozen_string_literal: true

require 'test_helper'

class BoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    puts '---'
    puts host
    puts sessions_url
    login_user create :user
  end

  test 'should get index' do
    get boards_url
    assert_response :success
  end
end
