# frozen_string_literal: true

class InviteMailer < ApplicationMailer
  def invite(invite_id)
    @invite = Invite.find invite_id
    @inviter = @invite.inviter
    @url = accept_invite_url(@invite.token)

    mail(to: @invite.email,
         subject: 'Приглашение в tasky.online')
  end
end
