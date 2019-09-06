# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'create user with nickname' do
    user = create :user
    assert user.nickname
  end
end
