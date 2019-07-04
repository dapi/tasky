# frozen_string_literal: true

require 'test_helper'

class TaskHistoryTest < ActiveSupport::TestCase
  test 'task attachment commands' do
    task = create :task
    task_attachment = create :task_attachment, task: task

    TaskHistory.new(task).add_attachment task_attachment
    assert_equal 1, task.reload.comments_count

    user = create :user
    task_attachment.destroy!
    TaskHistory.new(task_attachment.task).remove_attachment user, task_attachment
    assert_equal 2, task.reload.comments_count
  end

  test 'task commands' do
    task = create :task

    TaskHistory.new(task).create_task
    assert_equal 1, task.reload.comments_count

    user = create :user
    TaskHistory.new(task).remove_task user
    assert_equal 2, task.reload.comments_count
  end
end
