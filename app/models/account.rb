# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id, inverse_of: :owned_accounts
  has_many :account_memberships, dependent: :delete_all
  has_many :members, through: :account_memberships, class_name: 'User'
  has_many :invites, dependent: :delete_all
  has_many :boards, dependent: :delete_all

  after_create :attach_owner

  private

  def attach_owner
    members << owner
  end
end
