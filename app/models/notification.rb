# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user

  scope :unread, -> { where read_at: nil }

  def mark_as_read!
    update_column read_at: Time.zone.now
  end

  def message
    I18n.t key, payload.merge(scope: :notifications)
  end
end
