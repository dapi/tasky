# frozen_string_literal: true

class BoardInvitesController < ApplicationController
  skip_before_action :require_login

  def accept
    raise HumanizedError, 'Выйдите из системы чтобы воспользоваться ссылкой-приглашением' if logged_in?

    board_invite = BoardInvite.find_by! token: params[:id]

    accept_invite board_invite

    redirect_to board_path(board_invite.board), notice: 'Добро пожаловать!'
  rescue ActiveRecord::RecordNotFound
    raise HumanizedError, 'Данная ссылка уже устарела. Попросите новый инвайт'
  end

  private

  def accept_invite(board_invite)
    board_invite.with_lock do
      user = User.create!(email: board_invite.email, name: board_invite.email.split('@').first)
      board_invite.account.members << user
      board_invite.board.members << user
      auto_login user
    end
  end
end
