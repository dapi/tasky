# frozen_string_literal: true

class CardMembership < ApplicationRecord
  belongs_to :card
  belongs_to :account_membership

  has_one :member, through: :account_membership

  scope :ordered, -> { order :id }
end
