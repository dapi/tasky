# frozen_string_literal: true

require 'test_helper'

class InvitesControllerTest < ActionDispatch::IntegrationTest
  test 'should get accept invite to account' do
    invite = create :invite
    get accept_invite_url(invite.token)
    assert_response :redirect
    # assert_redirected_to board_url(invite.board, subdomain: invite.account.subdomain)
    assert_redirected_to account_url(subdomain: invite.account.subdomain)
  end

  test 'should get accept invite to board' do
    invite = create :invite
    invite.update board: create(:board, account: invite.account)
    get accept_invite_url(invite.token)
    assert_response :redirect
    assert_redirected_to board_url(invite.board, subdomain: invite.account.subdomain)
  end
end
