# frozen_string_literal: true

class BoardMembershipSerializer
  include FastJsonapi::ObjectSerializer
  set_type :board_membership

  belongs_to :board
  belongs_to :member, record_type: :user, serializer: :User
end
