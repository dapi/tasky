# frozen_string_literal: true

require 'test_helper'

class TaskHistoryTest < ActiveSupport::TestCase
  test 'attachment commands' do
    task = create :task
    task_attachment = create :task_attachment, task: task

    TaskHistory.new(task_attachment.task).add_attachment task_attachment

    assert task.reload.comments_count == 1
    task_attachment.destroy!

    user = create :user
    TaskHistory.new(task_attachment.task).remove_attachment user, task_attachment
    assert task.reload.comments_count == 2
  end
end
