# frozen_string_literal: true

require 'test_helper'

class AccountMembershipTest < ActiveSupport::TestCase
  test "Can't remove owner from memberships" do
    account = create :account

    assert_raises do
      account.member.destroy_all!
    end
  end

  test 'add and remove member' do
    account = create :account
    user = create :user
    account.members << user
    assert account.members.count == 2

    assert_nothing_raised do
      account.members.where(id: user.id).destroy_all
    end

    assert account.members.one?
  end
end
