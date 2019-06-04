# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer
  set_type :user

  attributes :email
end
