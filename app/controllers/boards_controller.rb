# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :require_login

  def index
    render locals: { accounts: current_user.accounts }
  end
end
