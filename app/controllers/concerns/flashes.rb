# frozen_string_literal: true

module Flashes
  private

  def flash_alert!(key = :alert, options = {})
    flash.alert = key.is_a?(Symbol) ? t_flash(key, options) : key
  end

  def flash_notice!(key = :notice, options = {})
    flash.notice = key.is_a?(Symbol) ? t_flash(key, options) : key
  end

  def t_flash(key = :notice, options = {})
    options.merge! scope: [:flashes, controller_name, action_name]
    options[:default] = I18n.t(key, scope: [:flashes]) unless %i[alert notice].include?(key)
    t key, options
  end
end
