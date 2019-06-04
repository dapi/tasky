# frozen_string_literal: true

class AccountMembership < ApplicationRecord
  belongs_to :user
  belongs_to :account
end
