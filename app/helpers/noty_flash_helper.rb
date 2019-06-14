# frozen_string_literal: true

module NotyFlashHelper
  DEFAULT_TYPE = :info
  TYPES = { alert: :error, notice: :info }.freeze

  def noty_flashes
    flash.map do |key, value|
      javascript_tag(noty_flash_javascript(value, key))
    end.join.html_safe # rubocop:disable Rails/OutputSafety
  end

  def noty_type_for(key)
    noty_type = TYPES[(key || :notice).to_sym]

    return noty_type if noty_type

    ::Rails.logger.warn "NotyFlash: Unknown flash type (#{key}), use default (#{DEFAULT_TYPE})"

    DEFAULT_TYPE
  end

  def noty_flash_javascript(message, key)
    "document.addEventListener(\"DOMContentLoaded\",function(){window.NotyFlash.show(#{message.to_json}, #{noty_type_for(key).to_json})});" # rubocop:disable Metrics/LineLength
  end
end
