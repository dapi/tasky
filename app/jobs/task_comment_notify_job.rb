# frozen_string_literal: true

class TaskCommentNotifyJob < ApplicationJob
  def perform(task_comment_id)
    task_comment = TaskComment.find task_comment_id
    TaskChannel.broadcast_to task_comment.task, TaskSerializer.new(task_comment.task, include: [:attachments]).as_json
    task_comment.boards.find_each do |board|
      BoardChannel.broadcast_to(board, BoardPresenter.new(board).data)
    end
  end
end
