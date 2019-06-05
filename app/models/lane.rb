# frozen_string_literal: true

class Lane < ApplicationRecord
  nilify_blanks

  include LaneStages
  include Sortable.new parent_id: :board_id

  belongs_to :board
  has_many :tasks, -> { ordered }, inverse_of: :lane

  validates :title, presence: true, uniqueness: { scope: :board_id }
end
