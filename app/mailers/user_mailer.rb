# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def reset_password_email(user)
    @user = User.find user.id
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail to: @user.mail_address
  end

  def invite(invite_id)
    @invite = Invite.find invite_id
    @inviter = @invite.inviter
    @url = accept_invite_url(@invite.token)

    mail to: @invite.email
  end
end
