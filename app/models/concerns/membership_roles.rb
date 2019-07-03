# frozen_string_literal: true

module MembershipRoles
  extend ActiveSupport::Concern
  ROLE_ENUMS = {
    owner: 0,
    user: 1
  }.freeze

  included do
    before_destroy :forbid_ownership_removing, if: :owner?
  end

  def owner?
    member_id == account.owner_id
  end

  def role
    owner? ? :owner : :user
  end

  def role_enum
    ROLE_ENUMS[role]
  end

  private

  def forbid_ownership_removing
    raise "Can't remove owner (#{member_id}) from account membership"
  end
end
