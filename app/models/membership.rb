class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :company

  enum role: [:user, :admin]
end
