# frozen_string_literal: true

class BoardSerializer
  include FastJsonapi::ObjectSerializer
  set_type :board

  belongs_to :account
  has_many :lanes
  has_many :memberships

  attributes :title
end
