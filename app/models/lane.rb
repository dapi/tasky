class Lane < ApplicationRecord
  belongs_to :dashboard

  validates :title, presence: true, uniqueness: [:dashboard_id]
end
