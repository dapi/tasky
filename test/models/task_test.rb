# frozen_string_literal: true

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test 'move second task across lanes' do
    from_lane = create :lane, :with_tasks, tasks_count: 3
    task = from_lane.tasks.ordered.second
    to_lane = create :lane, :with_tasks, tasks_count: 3
    assert_equal [0, 1, 2], to_lane.tasks.ordered.pluck(:position)

    task.change_position 0, to_lane

    assert_equal task.lane, to_lane
    assert_equal task.reload.position, 0
    assert_equal [0, 1, 2, 3], to_lane.tasks.ordered.pluck(:position)
    assert_equal [0, 1], from_lane.tasks.ordered.pluck(:position)
  end

  test 'move last task across lanes' do
    from_lane = create :lane, :with_tasks, tasks_count: 3
    task = from_lane.tasks.ordered.last
    to_lane = create :lane, :with_tasks, tasks_count: 3
    assert_equal [0, 1, 2], to_lane.tasks.ordered.pluck(:position)

    task.change_position 0, to_lane

    assert_equal task.lane, to_lane
    assert_equal task.reload.position, 0
    assert_equal [0, 1, 2, 3], to_lane.tasks.ordered.pluck(:position)
    assert_equal [0, 1], from_lane.tasks.ordered.pluck(:position)
  end

  test 'move task up' do
    lane = create :lane, :with_tasks, tasks_count: 3
    task = lane.tasks.ordered.last

    task.change_position 0

    assert_equal 0, task.position
    assert_equal [0, 1, 2], lane.tasks.ordered.pluck(:position)
  end

  test 'move task down' do
    lane = create :lane, :with_tasks, tasks_count: 3
    task = lane.tasks.ordered.first

    task.change_position 2

    assert_equal 2, task.position
    assert_equal [0, 1, 2], lane.tasks.ordered.pluck(:position)
  end
end
