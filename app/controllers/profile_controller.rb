# frozen_string_literal: true

class ProfileController < ApplicationController
  layout false

  before_action :xhr_only!

  def show
    render locals: { user: current_user, back_url: params[:back_url] }
  end

  def update
    current_user.update! permitted_params
    flash_notice!

    redirect_to params[:back_url] || accounts_url
  rescue ActiveRecord::RecordInvalid => e
    flash.alert = e.message
    render :show, locals: { user: e.record, back_url: params[:back_url] }
  end

  private

  def permitted_params
    params[:user].delete(:password) if params[:user][:password].blank?
    params.fetch(:user).permit(:name, :email, :password)
  end
end
