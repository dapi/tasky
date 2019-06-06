# frozen_string_literal: true

class SessionsController < ApplicationController
  layout 'simple'

  def new
    render locals: { user_session: UserSession.new, message: nil }
  end

  def create
    if user_session.valid?
      if login(user_session.login, user_session.password, true)
        redirect_back_or_to root_url, success: t('flashes.welcome', name: current_user.to_s)
      else
        render :new, locals: { user_session: user_session, message: t('flashes.wrong_credentials') }
      end
    else
      render :new, locals: { user_session: user_session, message: t('flashes.invalid_session_form') }
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: t('public.flashes.logout')
  end

  private

  def user_session
    @user_session ||= UserSession.new params[:user_session].permit(:login, :password, :remember_me)
  end
end
