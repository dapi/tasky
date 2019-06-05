# frozen_string_literal: true

FactoryBot.define do
  factory :board do
    account
    title { 'MyString' }
  end
end
