# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include RescueErrors
  include CurrentSuperAdmin
  include CurrentLocale
  include Flashes

  before_action :require_login

  def not_found
    super
  end

  private

  def xhr_only!
    raise 'XHR only requests available' unless request.xhr?
  end
end
