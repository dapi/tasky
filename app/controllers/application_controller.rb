# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include RescueErrors
  include CurrentAccount
  include CurrentLocale
  include Flashes

  helper_method :current_account

  before_action :require_login
end
