# frozen_string_literal: true

FactoryBot.define do
  factory :task_attachment do
    task
    user
    file { File.open Rails.root.join('test/assets/image.png') }
    file_size { 100_000 }
  end
end
