# frozen_string_literal: true

FactoryBot.define do
  factory :task_comment do
    task { nil }
    author { nil }
    content { 'MyString' }
  end
end
