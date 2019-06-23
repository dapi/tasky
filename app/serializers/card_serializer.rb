# frozen_string_literal: true

class CardSerializer
  include FastJsonapi::ObjectSerializer
  set_type :card

  belongs_to :lane
  belongs_to :board
  belongs_to :task

  attributes :position, :title, :details, :formatted_details, :comments_count
end
