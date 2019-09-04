# frozen_string_literal: true

require 'test_helper'

class NotificatorTest < ActiveSupport::TestCase
  test 'create only one notification (ignore author) for move_across_lanes' do
    watcher = create :user
    account = create :account
    card = create :card, account: account
    from_lane = create :lane, account: account
    to_lane = create :lane, account: account

    author = create :user
    watchers = [watcher, author]

    Notificator.new(watchers).move_across_lanes card: card, user: author, from_lane: from_lane, to_lane: to_lane

    assert Notification.all.one?
  end
end
