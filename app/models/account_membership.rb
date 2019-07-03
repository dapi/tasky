# frozen_string_literal: true

class AccountMembership < ApplicationRecord
  include MembershipRoles
  belongs_to :member, class_name: 'User'
  belongs_to :account

  validates :member_id, uniqueness: { scope: :account_id }

  def owner?
    member_id == account.owner_id
  end
end
