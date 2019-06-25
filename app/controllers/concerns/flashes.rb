# frozen_string_literal: true

module Flashes
  private

  def flash_notice(key = :success)
    flash.notice = t key, scope: [:flashes, controller_name, action_name]
  end
end
