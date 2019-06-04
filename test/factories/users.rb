# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
  factory :user, aliases: %i[owner inviter invitee] do
    email
  end
end
