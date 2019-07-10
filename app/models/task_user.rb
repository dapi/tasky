# frozen_string_literal: true

class TaskUser < ApplicationRecord
  belongs_to :task
  belongs_to :user

  has_many :comments, through: :task

  def unseen_comments_count
    comments.where('task_comments.created_at > ?', seen_at).count
  end
end
