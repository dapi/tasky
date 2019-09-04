# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user

  scope :unread, -> { where read_at: nil }

  def mark_as_read!
    update_column read_at: Time.zone.now
  end

  def message
    I18n.t key, deep_interpolation(payload).merge(scope: :notifications)
  end

  private

  def deep_interpolation(hash, prefix = '')
    buffer = {}
    hash.each_pair do |key, value|
      if value.is_a? Hash
        buffer.merge! deep_interpolation(value, key.to_s + '_')
      else
        buffer[(prefix + key.to_s).to_sym] = value
      end
    end
    buffer
  end
end
