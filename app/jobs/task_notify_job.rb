# frozen_string_literal: true

class TaskNotifyJob < ApplicationJob
  def perform(task_id)
    TaskChannel.update_task Task.find task_id
  end
end
