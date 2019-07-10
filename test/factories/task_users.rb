# frozen_string_literal: true

FactoryBot.define do
  factory :task_user do
    task
    user
  end
end
