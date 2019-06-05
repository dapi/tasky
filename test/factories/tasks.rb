# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    lane { nil }
    author { nil }
    title { 'MyString' }
    detail { 'MyText' }
    completed_at { '2019-06-05 16:11:43' }
    deadline_date { '2019-06-05' }
    deadline_time { '2019-06-05' }
    position { 1 }
  end
end
