# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    account
    author
    title
    details { 'MyText' }
  end
end
