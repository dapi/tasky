# frozen_string_literal: true

class TaskComment < ApplicationRecord
  nilify_blanks

  belongs_to :task, counter_cache: :comments_count
  belongs_to :author, class_name: 'User'

  has_many :cards, through: :task
  has_many :boards, through: :cards

  scope :ordered, -> { order 'created_at desc' }

  validates :content, presence: true
end
