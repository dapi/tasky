# frozen_string_literal: true

class TaskComment < ApplicationRecord
  belongs_to :task
  belongs_to :author, class_name: 'User'

  scope :ordered, -> { order :created_at }
end
