# frozen_string_literal: true

require 'test_helper'

class BoardMembershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user create :user
    account = create :account, owner: @current_user
    @board = create :board, account: account
  end

  test 'should delete membership' do
    membership = create :board_membership, board: @board
    delete board_membership_url(membership)
    assert_response :success
    assert_equal membership.reload, nil
  end
end
