# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :require_login
  layout 'simple'

  def new
    render locals: { user: user }
  end

  def create
    unless verify_recaptcha(model: user)
      Bugsnag.notify 'not valid captcha'
      flash.alert = 'Не подтверждена captcha. Попробуйте отправить форму еще раз'
      render :new, locals: { user: user }
      return
    end
    user.save!

    auto_login user
    flash.notice = 'Поздравляю, вы зарегистрированы! Можете установить свой пароль в профиле'

    redirect_to board_path create_board!
  rescue ActiveRecord::RecordInvalid => e
    flash.alert = e.message
    render :new, locals: { user: e.record }
  end

  private

  def permitted_params
    params.fetch(:user, {}).permit(:email, :name, :password)
  end

  def user
    @user ||= User.new permitted_params
  end

  def create_board!
    current_user.transaction do
      account = current_user.owned_accounts.create! name: current_user.name
      account.boards.create_with_member!({ title: 'Доска N1' }, member: current_user)
    end
  end
end
