# frozen_string_literal: true

class SuperUsersController < ApplicationController
  before_action do
    raise NotAuthenticated, 'Only super admin can do it!' unless current_super_admin.present? && current_super_admin.is_super_admin?

    save_current_super_admin!
  end

  # Login by other user
  #
  def create
    user = User.find params[:user_id]
    reset_session
    auto_login user
    flash_notice! "Welcome, #{user.public_name}!"
    redirect_to accounts_url
  end
end
