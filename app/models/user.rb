# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!
  nilify_blanks

  has_many :owned_accounts, class_name: 'Account', inverse_of: :owner, foreign_key: :owner_id, dependent: :destroy
  has_many :account_memberships, inverse_of: :member, foreign_key: :member_id, dependent: :delete_all
  has_many :accounts, -> { ordered }, through: :account_memberships

  has_many :board_memberships, inverse_of: :member, foreign_key: :member_id, dependent: :delete_all
  has_many :boards, -> { ordered }, through: :board_memberships

  has_many :available_boards, through: :accounts, source: :boards

  has_many :authored_tasks, class_name: 'Task', foreign_key: :author_id, dependent: :restrict_with_error, inverse_of: :author

  has_many :available_lanes, through: :boards, source: :lanes
  has_many :available_tasks, through: :lanes, source: :tasks

  validates :name, presence: true
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
