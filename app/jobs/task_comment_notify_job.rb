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
    task.cards.includes(:board).find_each do |card|
      BoardChannel.update_with_card card.board, card
    end
  end
end
