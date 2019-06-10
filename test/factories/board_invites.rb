# frozen_string_literal: true

FactoryBot.define do
  factory :board_invite do
    board
    invite
    inviter
  end
end
