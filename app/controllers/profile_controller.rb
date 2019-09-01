# frozen_string_literal: true

class ProfileController < ApplicationController
  layout false

  before_action :xhr_only!

  def show
    render locals: { user: current_user }
  end

  def update
    current_user.update! permitted_params
    flash_notice!

    render :show, locals: { user: current_user }
  rescue ActiveRecord::RecordInvalid => e
    flash.alert = e.message
    render :show, locals: {
      user: e.record
    }
  end

  private

  def permitted_params
    params[:user].delete(:password) if params[:user][:password].blank?
    params.fetch(:user).permit(:name, :email, :password)
  end
end
