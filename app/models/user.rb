# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!
  nilify_blanks

  has_many :owned_accounts, class_name: 'Account', inverse_of: :owner, foreign_key: :owner_id, dependent: :destroy
  has_many :account_memberships, dependent: :destroy
  has_many :accounts, through: :account_memberships

  validates :email, email: true, presence: true, uniqueness: true

  before_create :generate_access_key

  def public_name
    name.presence || email
  end

  private

  def generate_access_key
    self.access_key = SecureRandom.hex(20)
  end
end
