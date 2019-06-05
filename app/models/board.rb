# frozen_string_literal: true

class Board < ApplicationRecord
  nilify_blanks
  belongs_to :account

  validates :title, presence: true, uniqueness: { scope: :account_id }

  scope :ordered, -> { order :id }
end
