# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: %i[owner inviter invitee member] do
    email
    name
    password { 'password' }
  end
end
