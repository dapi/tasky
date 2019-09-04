# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    user
    key { :move_across_lanes }
  end
end
