# frozen_string_literal: true

FactoryBot.define do
  factory :lane do
    board
    title

    trait :with_tasks do
      transient do
        tasks_count { 3 }
      end

      after(:create) do |lane, evaluator|
        create_list(:task, evaluator.tasks_count, lane: lane)
      end
    end
  end
end
