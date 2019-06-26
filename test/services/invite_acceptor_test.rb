# frozen_string_literal: true

require 'test_helper'

class InvitAcceptorTest < ActiveSupport::TestCase
  test 'invite accepted' do
    invite = create :invite
    user = InviteAcceptor
           .new(invite)
           .accept!

    assert user.present?
    assert_equal user.email, invite.email
  end
end
