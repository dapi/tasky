# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include RescueErrors

  before_action :require_login
end
