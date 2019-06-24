# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include RescueErrors
  include CurrentAccount
  include CurrentLocale

  helper_method :current_account

  before_action :require_login
end
