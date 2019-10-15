# frozen_string_literal: true

require 'test_helper'

class BoardMembershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user create :user
  end

  test 'should delete membership' do
    account = create :account, owner: @current_user
    board = create :board, account: account
    assert @current_user.available_boards.include? board
    membership = create :board_membership, board: board
    delete board_membership_url(membership.id)
    assert_response :success
    assert_equal membership.reload, nil
  end
end
