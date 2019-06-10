# frozen_string_literal: true

class BoardInvite < ApplicationRecord
  belongs_to :inviter, class_name: 'User'
  belongs_to :board
  belongs_to :invite
  has_one :invitee, through: :invite, class_name: 'User'

  before_create :create_member, if: :invitee

  private

  def create_member
    board.members << invite.invitee
  end
end
