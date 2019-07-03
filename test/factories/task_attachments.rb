# frozen_string_literal: true

FactoryBot.define do
  factory :task_attachment do
    task { nil }
    user { nil }
    file { 'MyString' }
    file_size { 1 }
  end
end
