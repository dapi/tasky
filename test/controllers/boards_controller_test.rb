# frozen_string_literal: true

require 'test_helper'

class BoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user create :user
  end

  test 'should create board' do
    account = create :account, owner: @current_user
    assert account.boards.empty?
    post boards_url(board: { title: 'Some title', account_id: account.id }), xhr: true
    assert_response :success
    assert account.boards.one?
  end
end
