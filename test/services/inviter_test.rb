# frozen_string_literal: true

require 'test_helper'

class InviterTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  setup do
    @inviter = create :inviter
    @board = create :board
    @account = @board.account
    ActionMailer::Base.deliveries.clear
  end

  test 'wrong email format' do
    assert_raises ActiveRecord::RecordInvalid do
      Inviter
        .new(email: 'wrong', account: @account, board: @board, inviter: @inviter)
        .perform!
    end
  end

  test 'user is not exists' do
    assert_emails 0
    email = generate :email
    result = Inviter
             .new(account: @account, email: email, board: @board, inviter: @inviter)
             .perform!

    assert result == :invited
    assert @account.invites.where(email: email, board: @board).one?
    assert_emails 1
  end

  test 'user is registered, but has no access to the account' do
    assert_emails 0
    user = create :user
    result = Inviter
             .new(account: @account, email: user.email, board: @board, inviter: @inviter)
             .perform!

    assert result == :membership_created
    assert_includes @account.members, user
    assert_includes @board.members, user
    assert_emails 0
  end

  test 'user is registered, and already has access to the board' do
    user = create :user
    @account.members << user
    result = Inviter
             .new(account: @account, email: user.email, inviter: @inviter)
             .perform!
    assert result == :membership_created
    assert_emails 0
  end
end
