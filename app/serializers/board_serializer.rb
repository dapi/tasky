# frozen_string_literal: true

class BoardSerializer
  include FastJsonapi::ObjectSerializer
  set_type :board

  belongs_to :account

  attributes :title
end
