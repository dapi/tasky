# frozen_string_literal: true

class TaskComment < ApplicationRecord
  nilify_blanks

  belongs_to :task
  belongs_to :author, class_name: 'User'

  scope :ordered, -> { order 'created_at desc' }

  validates :content, presence: true
end
