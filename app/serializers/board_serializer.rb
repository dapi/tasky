# frozen_string_literal: true

class BoardSerializer
  include FastJsonapi::ObjectSerializer
  set_type :board

  belongs_to :account, unless: proc { |_record, params| params && params[:skip_belongs] }
  has_many :ordered_alive_lanes, record_type: :lane, serializer: :Lane
  has_many :memberships, serializer: :BoardMembership

  attributes :title, :metadata
end
