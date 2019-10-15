# frozen_string_literal: true

class LaneSerializer
  include FastJsonapi::ObjectSerializer
  set_type :lane

  belongs_to :board, unless: proc { |_record, params| params && params[:skip_belongs] }
  has_many :ordered_alive_cards, record_type: :card, serializer: :Card

  attributes :title, :position, :metadata
end
