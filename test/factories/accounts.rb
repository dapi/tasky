# frozen_string_literal: true

FactoryBot.define do
  sequence :name do |n|
    "name#{n}"
  end
  factory :account do
    owner
    name
  end
end
