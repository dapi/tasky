# frozen_string_literal: true

class CardMembershipSerializer
  include FastJsonapi::ObjectSerializer
  set_type :card_membership

  belongs_to :card
  belongs_to :account_membership, record_type: :account_membership, serializer: :AccountMembership

  has_one :member, record_type: :user, serializer: :User
end
