# frozen_string_literal: true

FactoryBot.define do
  factory :task_comment do
    task
    author
    content { 'MyString' }
  end
end
