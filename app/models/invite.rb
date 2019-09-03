# frozen_string_literal: true

class Invite < ApplicationRecord
  nilify_blanks

  belongs_to :account
  belongs_to :inviter, class_name: 'User'
  belongs_to :board, optional: true
  belongs_to :task, optional: true

  scope :ordered, -> { order :email }

  before_validation do
    self.email = email.downcase if email.present?
  end

  validates :email, presence: true, email: true, uniqueness: { scope: %i[account_id board_id task_id] }

  before_create { self.locale ||= inviter.locale }
  before_create :generate_token

  private

  def generate_token
    self.token = SecureRandom.hex(20)
  end
end
