# frozen_string_literal: true

class Invite < ApplicationRecord
  belongs_to :account
  belongs_to :inviter, class_name: 'User'
  belongs_to :invitee, class_name: 'User', optional: true

  validates :email, presence: true, email: true, uniqueness: { scope: :account_id }
end
