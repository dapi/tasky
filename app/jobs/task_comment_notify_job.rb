# frozen_string_literal: true

class TaskCommentNotifyJob < ApplicationJob
  # Notify about TaskComment creation
  #
  def perform(task_comment_id)
    task_comment = TaskComment.find task_comment_id

    task = task_comment.task

    # Notify task about changes in attachments
    TaskChannel.update_task task

    TaskChannel.add_comment task, task_comment

    # Notify board about changes in task.comments_count
    task.boards.find_each do |board|
      # TODO: Rename to BoardChannel.update_board
      BoardChannel.broadcast_to board, event: :update
    end
  end
end
