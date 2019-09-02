# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def reset_password_email
    user.generate_reset_password_token!
    UserMailer.reset_password_email user
  end

  def invite
    invite = Invite.first
    invite = Invite.create!(account: account, inviter: user, email: 'test@example.com') if invite.blank?
    UserMailer.invite invite.id
  end

  private

  def user
    @user ||= User.first
  end

  def account
    user.personal_account
  end
end
