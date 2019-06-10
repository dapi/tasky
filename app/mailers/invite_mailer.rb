# frozen_string_literal: true

class InviteMailer < ApplicationMailer
  def invite_to_account(account, _email)
    @account = Account.find account.id
    @url = account_url(@account)
    mail(to: account.email,
         subject: 'Приглашение в tasky.online')
  end

  def invite_to_board(board_invite)
    @board_invite = BoardInvite.find board_invite.id
    @url = accept_board_invite_url(@board_invite.token)
    mail(to: @board_invite.email,
         subject: 'Приглашение в tasky.online')
  end
end
