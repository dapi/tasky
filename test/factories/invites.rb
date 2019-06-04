# frozen_string_literal: true

FactoryBot.define do
  factory :invite do
    account
    inviter
    email
  end
end
