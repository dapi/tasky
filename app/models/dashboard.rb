# frozen_string_literal: true

class Dashboard < ApplicationRecord
  belongs_to :company
  belongs_to :owner

  validates :title, presence: true, uniqueness: [:company_id]
end
