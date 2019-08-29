# frozen_string_literal: true

require 'test_helper'

class BoardCreatorTest < ActiveSupport::TestCase
  test 'perform' do
    account = create :account
    user = create :user

    board = BoardCreator
            .new(account)
            .perform(attrs: { title: 'test' }, owner: user)

    assert_includes board.members, user
  end
end
