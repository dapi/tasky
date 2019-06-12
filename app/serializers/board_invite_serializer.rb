# frozen_string_literal: true

class BoardInviteSerializer
  include FastJsonapi::ObjectSerializer
  set_type :board_invite

  belongs_to :board

  attribute :email
end
