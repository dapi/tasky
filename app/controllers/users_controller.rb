# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :require_login
  before_action :validate_captcha, only: [:create]
  layout 'simple'

  def new
    render locals: { user: user }
  end

  # rubocop:disable Metrics/AbcSize
  def create
    user.save!

    accept_invites! user

    auto_login user

    board = create_board!

    redirect_to board_url(board, subdomain: board.account.subdomain),
                notice: flash_t
  rescue ActiveRecord::RecordInvalid => e
    flash_alert! e.message
    render :new, locals: { user: e.record }
  end
  # rubocop:enable Metrics/AbcSize

  private

  def validate_captcha
    return if verify_recaptcha model: user

    Bugsnag.notify 'not valid captcha'
    flash_alert! :invalid_captcha
    render :new, locals: { user: user }
  end

  def permitted_params
    params.fetch(:user, {}).permit(:email, :name, :password, :locale)
  end

  def user
    @user ||= User.new permitted_params
  end

  # TODO: async
  def accept_invites!(user)
    Invite.where(email: user.email).find_each do |invite|
      InviteAcceptor.new(invite, user).accept!
    end
  end

  def create_board!
    current_user.transaction do
      account = current_user.owned_accounts.create! name: current_user.name
      account.boards.create_with_member!({ title: current_user.public_name }, member: current_user)
    end
  end
end
