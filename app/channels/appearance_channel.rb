# frozen_string_literal: true

# example https://www.npmjs.com/package/@rails/actioncable
class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    current_user.appear
  end

  def unsubscribed
    current_user.disappear
  end

  def appear(data)
    current_user.appear on: data['appearing_on']
  end

  delegate :away, to: :current_user
end
