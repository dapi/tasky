# frozen_string_literal: true

class AccountSerializer
  include FastJsonapi::ObjectSerializer
  set_type :account

  belongs_to :owner, record_type: :user, serializer: :UserSystem

  attributes :name
end
