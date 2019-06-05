# frozen_string_literal: true

FactoryBot.define do
  factory :lane do
    board { nil }
    title { '' }
    stage { 1 }
  end
end
