# frozen_string_literal: true

require 'test_helper'

class BoardInvitesControllerTest < ActionDispatch::IntegrationTest
  test 'should get accept' do
    board_invite = create :board_invite
    get accept_board_invite_url(board_invite.token)
    assert_response :redirect
  end
end
