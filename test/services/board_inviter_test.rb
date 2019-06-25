# frozen_string_literal: true

require 'test_helper'

class BoardInviterTest < ActiveSupport::TestCase
  setup do
    @inviter = create :inviter
    @board = create :board
  end

  test 'wrong email format' do
    assert_raises ActiveRecord::RecordInvalid do
      BoardInviter
        .new(email: 'wrong', board: @board, inviter: @inviter)
        .perform!
    end
  end

  test 'user is not exists' do
    board_invite = BoardInviter
                   .new(email: generate(:email), board: @board, inviter: @inviter)
                   .perform!

    assert board_invite.persisted?
    assert board_invite.invitee.nil?
  end

  test 'user is registered, but has no access to the account' do
    user = create :user

    board_invite = BoardInviter
                   .new(email: user.email, board: @board, inviter: @inviter)
                   .perform!

    # TODO: do we actualy need to create board_invite?
    assert board_invite.persisted?
    assert board_invite.invitee.persisted?
    assert_includes @board.account.members, user
    assert_includes @board.members, user
  end

  test 'user is registered, and already has access to the board' do
  end
end
