# frozen_string_literal: true

class TaskCommentNotifyJob < ApplicationJob
  def perform(task_comment_id)
    task_comment = TaskComment.find task_comment_id

    # Notify task about changes in comments_count
    TaskChannel.broadcast_to task_comment.task, TaskSerializer.new(task_comment.task, include: [:attachments]).as_json

    # Notify board about changes in comments_count
    task_comment.boards.find_each do |board|
      BoardChannel.broadcast_to(board, BoardPresenter.new(board).data)
    end
  end
end
