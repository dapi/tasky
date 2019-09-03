# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def reset_password_email(user)
    @user = User.find user.id
    @url  = edit_password_reset_url(@user.reset_password_token)

    with_locale(@user.locale) do
      mail to: @user.mail_address
    end
  end

  def invite(invite_id)
    @invite = Invite.find invite_id
    @inviter = @invite.inviter
    @url = accept_invite_url(@invite.token)

    with_locale(@invite.locale) do
      mail to: @invite.email
    end
  end

  private

  def with_locale(user_locale, &block)
    # Let choice locale in mail preview
    I18n.with_locale Rails.env.development? ? locale : user_locale, &block
  end
end
