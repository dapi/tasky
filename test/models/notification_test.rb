# frozen_string_literal: true

require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  test 'generate message' do
    notification = create :notification, payload: {
      card: { title: 'CARD_TITLE' },
      from_lane: { title: 'FROM_LANE' },
      to_lane: { title: 'TO_LANE' }
    }
    assert notification.message
  end
end
