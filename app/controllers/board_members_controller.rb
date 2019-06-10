# frozen_string_literal: true

class BoardMembersController < ApplicationController
  helper_method :board

  def new
    render locals: { board_invite: BoardInvite.new }
  end

  def create
    board_invite = BoardInviter
                   .new(board: board, inviter: current_user, email: params.require(:board_invite).fetch(:email))
                   .perform!

    flash.noticy = "Пользователь #{board_invite.email} пришлашен"

    redirect_to board_path(board)
  end

  def index
    render locals: { members: board.members }
  end

  private

  def board
    current_user.boards.find params[:board_id]
  end
end
