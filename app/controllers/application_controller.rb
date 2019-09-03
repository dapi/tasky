# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include RescueErrors
  include CurrentSuperAdmin
  include CurrentLocale
  include Flashes

  before_action :require_login
  after_action  :clear_xhr_flash, if: :xhr?

  def not_found
    super
  end

  private

  delegate :xhr?, to: :request

  def xhr_only!
    raise 'XHR only requests available' unless request.xhr?
  end

  def clear_xhr_flash
    # Also modify 'flash' to other attributes which you use in your common/flashes for js
    flash.discard
  end
end
