# frozen_string_literal: true

class BoardMembersController < ApplicationController
  helper_method :board

  def index
    render locals: { members: board.members }
  end

  private

  def board
    current_user.boards.find params[:board_id]
  end
end
