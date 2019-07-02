# frozen_string_literal: true

class BoardMembership < ApplicationRecord
  belongs_to :board
  belongs_to :member, class_name: 'User'

  has_one :account, through: :board

  scope :ordered, -> { order :id }

  validates :member_id, uniqueness: { scope: :board_id }
end
