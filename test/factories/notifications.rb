# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    user
    key { 'key' }
  end
end
