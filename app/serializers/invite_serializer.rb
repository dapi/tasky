# frozen_string_literal: true

class InviteSerializer
  include FastJsonapi::ObjectSerializer
  set_type :invite

  belongs_to :account
  belongs_to :inviter, record_type: :user, serializer: :User
  belongs_to :invitee, record_type: :user, serializer: :User

  attributes :email
end
