# frozen_string_literal: true

class TaskCommentNotifyJob < ApplicationJob
  # Notify about TaskComment creation
  #
  def perform(task_comment_id)
    task_comment = TaskComment.find task_comment_id

    task = task_comment.task

    TaskChannel.update_task task
    TaskChannel.add_comment task, task_comment
  end
end
