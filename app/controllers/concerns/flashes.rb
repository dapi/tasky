# frozen_string_literal: true

module Flashes
  private

  def flash_alert!(key = :alert)
    flash.alert = key.is_a?(Symbol) ? flash_t(key) : key
  end

  def flash_notice!(key = :notice)
    flash.notice = key.is_a?(Symbol) ? flash_t(key) : key
  end

  def flash_t(key = :notice)
    t key, scope: [:flashes, controller_name, action_name]
  end
end
