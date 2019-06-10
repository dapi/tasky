# frozen_string_literal: true

require 'test_helper'

class BoardInviteTest < ActiveSupport::TestCase
  test 'invite create' do
    assert create :board_invite
  end
end
