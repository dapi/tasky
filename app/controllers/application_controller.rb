# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include RescueErrors
  include CurrentAccount
  include CurrentLocale
  include Flashes

  helper_method :current_account

  before_action :require_login, except: [:switch_locale]

  def switch_locale
    save_locale params[:locale]
    flash_notice
    redirect_back fallback_location: root_url
  end
end
