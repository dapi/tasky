# frozen_string_literal: true

require 'test_helper'

class InviteTest < ActiveSupport::TestCase
  test 'create invite' do
    invite = create :invite
    assert invite
  end

  test 'add membership if user is exists' do
    invitee = create :user
    invite = create :invite, email: invitee.email

    assert_includes invite.account.members, invitee
  end

  test 'raise an error if user is already member' do
    user = create :user
    account = create :account

    account.members << user

    assert_raises ActiveRecord::RecordInvalid do
      create :invite, email: user.email, account: account
    end
  end
end
