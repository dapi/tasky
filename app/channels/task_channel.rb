# frozen_string_literal: true

class TaskChannel < ApplicationCable::Channel
  NAME = 'task'

  def self.update_task(task)
    TaskChannel.broadcast_to task, {event: :update_task}.merge(TaskSerializer.new(task, include: [:attachments]).as_json)
  end

  def self.add_comment(task, comment)
    TaskChannel.broadcast_to task, {event: :add_comment}.merge(TaskCommentSerializer.new(comment, include: [:author]).as_json)
  end

  def subscribed
    task = Task.find params[:id]
    stream_for task
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
