# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :owned_accounts, class_name: 'Account', inverse_of: :owner, foreign_key: :owner_id
  has_many :account_memberships
  has_many :accounts, through: :account_memberships

  def public_name
    name.presence || email
  end
end
