# frozen_string_literal: true

FactoryBot.define do
  factory :lane do
    board
    title

    trait :with_cards do
      transient do
        cards_count { 3 }
      end

      after(:create) do |lane, evaluator|
        create_list(:card, evaluator.cards_count, lane: lane)
      end
    end
  end
end
