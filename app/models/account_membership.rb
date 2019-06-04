# frozen_string_literal: true

class AccountMembership < ApplicationRecord
  belongs_to :member, class_name: 'User'
  belongs_to :account

  validates :member_id, uniqueness: { scope: :account_id }
end
