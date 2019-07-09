# frozen_string_literal: true

class TaskUser < ApplicationRecord
  belongs_to :task
  belongs_to :user
end
