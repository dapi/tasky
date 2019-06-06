# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    redirect_to boards_path
  end
end
