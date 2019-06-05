# frozen_string_literal: true

class LaneSerializer
  include FastJsonapi::ObjectSerializer
  set_type :lane

  belongs_to :board

  attributes :title, :position
end
