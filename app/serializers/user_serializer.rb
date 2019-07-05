# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer
  set_type :user

  attributes :email, :public_nickname, :avatar_url

  attribute :access_key, if: proc { |_record, params|
    params && params[:show_private] == true
  }
end
