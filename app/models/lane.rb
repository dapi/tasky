# frozen_string_literal: true

class Lane < ApplicationRecord
  include RankedModel

  nilify_blanks

  belongs_to :board

  ranks :row_order, with_same: :board_id

  validates :title, presence: true, uniqueness: { scope: :board_id }

  enum stage: %i[todo doing done]
end
