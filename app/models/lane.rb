# frozen_string_literal: true

class Lane < ApplicationRecord
  nilify_blanks

  include LaneStages

  belongs_to :board

  scope :ordered, -> { order :position }

  validates :title, presence: true, uniqueness: { scope: :board_id }

  before_create do
    self.position ||= board.lanes.maximum(:position).to_i + 1
  end
end
