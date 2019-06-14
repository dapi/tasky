# frozen_string_literal: true

class LaneSerializer
  include FastJsonapi::ObjectSerializer
  set_type :lane

  belongs_to :board
  has_many :cards

  attributes :title, :position, :metadata
end
