# frozen_string_literal: true

class BoardMembership < ApplicationRecord
  belongs_to :board
  belongs_to :member, class_name: 'User'

  has_one :account, through: :board

  scope :ordered, -> { order :id }

  validates :member_id, uniqueness: { scope: :board_id }

  before_destroy :forbid_ownership_removing, if: :owner?

  def owner?
    member_id == board.owner_id
  end

  private

  def forbid_ownership_removing
    raise "Can't remove owner (#{member_id}) from board membership"
  end
end
