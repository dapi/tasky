# frozen_string_literal: true

class BoardInvitesController < ApplicationController
  helper_method :board

  private

  def board
    current_user.boards.find params[:board_id]
  end
end
