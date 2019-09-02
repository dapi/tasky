# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def reset_password_email(user)
    @user = User.find user.id
    @url  = edit_password_reset_url(@user.reset_password_token)
    I18n.with_locale(choice_locale(@user)) do
      mail to: @user.mail_address
    end
  end

  def invite(invite_id)
    @invite = Invite.find invite_id
    @inviter = @invite.inviter
    @url = accept_invite_url(@invite.token)

    I18n.with_locale(choice_locale(@inviter)) do
      mail to: @invite.email
    end
  end

  private

  def choice_locale(user)
    # Let choice locale in mail preview
    return locale if Rails.env.development?

    user.locale || locale
  end
end
