# frozen_string_literal: true

require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test 'owner is automaticaly added to members' do
    user = create :user
    account = create :account, owner: user
    assert_includes account.members, user
  end
end
