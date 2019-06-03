# frozen_string_literal: true

class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :company

  enum role: %i[user admin]
end
