# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: %i[author owner inviter invitee member] do
    email
    name
    locale { 'en' }
    password { 'password' }
  end
end
