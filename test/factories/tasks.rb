# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    lane
    author
    title
    details { 'MyText' }
  end
end
