# frozen_string_literal: true

require 'test_helper'

class TaskSeenTest < ActiveSupport::TestCase
  test 'mark as seen' do
    task = create :task
    user = create :user

    time = Time.zone.now
    TaskSeen.new(task, user).mark_as_seen! time

    task_user = TaskUser.find_by(user: user, task: task)

    assert task_user.present?
    assert_equal time.to_i, task_user.seen_at.to_i

    time += 12.hours
    TaskSeen.new(task, user).mark_as_seen! time
    task_user = TaskUser.find_by(user: user, task: task)

    assert_equal time.to_i, task_user.seen_at.to_i
  end
end
