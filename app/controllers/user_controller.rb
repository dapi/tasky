class UserController < ApplicationController
  layout 'simple'

  def edit
    render locals: { user: current_user }
  end

  def update
    current_user.update! permitted_params
    flash.notice = 'Изменено'

    render :edit, locals: { user: current_user }
  rescue ActiveRecord::RecordInvalid => e
    flash.alert = e.message
    render :edit, locals: {
      user: e.record
    }
  end

  private

  def permitted_params
    params[:user].delete(:password) if params[:user][:password].blank?
    params.fetch(:user).permit(:name, :email, :password)
  end
end
