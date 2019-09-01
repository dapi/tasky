# frozen_string_literal: true

require 'test_helper'

class InvitesControllerTest < ActionDispatch::IntegrationTest
  test 'should get accept invite to account' do
    invite = create :invite
    get accept_invite_url(invite.token)
    assert_response :redirect
    assert_redirected_to account_url(invite.account)
  end

  test 'should get accept invite to board' do
    invite = create :invite
    board = create :board, account: invite.account
    invite.update board: board
    get accept_invite_url(invite.token)
    assert_response :redirect
    assert_redirected_to board_url(invite.board)
  end
end
