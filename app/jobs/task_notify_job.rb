# frozen_string_literal: true

class TaskNotifyJob < ApplicationJob
  def perform(task_id)
    task = Task.find task_id
    TaskChannel.broadcast_to task, TaskSerializer.new(task, include: [:attachments]).as_json
  end
end
