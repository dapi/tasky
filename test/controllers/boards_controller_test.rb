# frozen_string_literal: true

require 'test_helper'

class BoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user create :user
  end

  test 'should create board' do
    account = create :account, owner: @current_user
    assert account.boards.empty?
    post boards_url(board: { title: 'Some title' }, subdomain: account.subdomain)
    assert_response :redirect
    assert account.boards.one?
  end

  test 'should get index' do
    account = create :account, owner: @current_user
    get boards_url(subdomain: account.subdomain)
    assert_response :redirect
  end
end
