# frozen_string_literal: true

class AccountMembership < ApplicationRecord
  belongs_to :member, class_name: 'User'
  belongs_to :account

  validates :member_id, uniqueness: { scope: :account_id }

  before_destroy :forbid_ownership_removing, if: :owner?

  def owner?
    member_id == account.owner_id
  end

  private

  def forbid_ownership_removing
    raise "Can't remove owner (#{member_id}) from account membership"
  end
end
