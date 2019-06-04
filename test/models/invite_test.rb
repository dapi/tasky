# frozen_string_literal: true

require 'test_helper'

class InviteTest < ActiveSupport::TestCase
  test 'create invite' do
    invite = create :invite
    assert invite
  end
end
