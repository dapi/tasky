# frozen_string_literal: true

class BoardInvite < ApplicationRecord
  belongs_to :inviter, class_name: 'User'
  belongs_to :board
  belongs_to :invite

  has_one :account, through: :board
  has_one :invitee, through: :invite, class_name: 'User'

  before_create :create_member, if: :invitee
  before_create :generate_token

  delegate :email, to: :invite

  private

  def generate_token
    self.token = SecureRandom.hex(20)
  end

  def create_member
    board.members << invite.invitee
  end
end
