# frozen_string_literal: true

class Notificator
  def initialize(watchers)
    @watchers = watchers
  end

  def move_across_lanes(card:, user:, from_lane:, to_lane:)
    payload = {
      card: card.as_json(only: %i[id task_id], methods: [:title]),
      from_lane: from_lane.as_json(only: %i[title id]),
      to_lane: to_lane.as_json(only: %i[title id]),
      user: user.as_json(only: %i[id public_nickname])
    }

    create_notifications watchers.reject { |w| w == user }, :move_across_lanes, payload
  end

  private

  attr_reader :watchers

  def create_notifications(watchers, key, payload)
    Notification.create!(
      watchers
      .map do |watcher|
        {
          user: watcher,
          key: key,
          payload: payload
        }
      end
    )
  end
end
