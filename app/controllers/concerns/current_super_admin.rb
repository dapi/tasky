# frozen_string_literal: true

module CurrentSuperAdmin
  extend ActiveSupport::Concern

  included do
    helper_method :current_super_admin
  end

  private

  def save_current_super_admin!
    cookies.encrypted[:super_admin_user_id] = current_super_admin.id
  end

  def current_super_admin
    if current_user.is_super_admin?
      current_user
    elsif cookies.encrypted[:super_admin_user_id].present?
      user = User.find_by(id: cookies.encrypted[:super_admin_user_id])
      return user if user.is_super_admin?
    end
  end
end
