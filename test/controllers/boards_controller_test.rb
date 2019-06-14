# frozen_string_literal: true

require 'test_helper'

class BoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user create :user
  end

  test 'should get index' do
    account = create :account, owner: @current_user
    get boards_url(subdomain: account.subdomain)
    assert_response :redirect
  end
end
