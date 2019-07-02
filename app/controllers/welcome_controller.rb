# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_before_action :require_login

  layout 'simple'

  def index
    if logged_in?
      redirect_to accounts_url
    else
      redirect_to new_session_url
    end
  end
end
