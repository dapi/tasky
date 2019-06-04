class Account < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  has_many :account_memberships
  has_many :users, through: :account_memberships

  after_create :attach_owner

  private

  def attach_owner
    account_memberships.create! user: owner
  end
end
