# frozen_string_literal: true

require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  test 'creatable' do
    assert create :board
  end

  test 'create_with_member!' do
    account = create :account
    user = create :user

    board = account.boards.create_with_member!({ title: 'test' }, member: user)

    assert_includes board.members, user
  end
end
