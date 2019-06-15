# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_before_action :require_login

  layout 'simple'

  def index
    redirect_to accounts_url if logged_in?
  end
end
