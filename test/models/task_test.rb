# frozen_string_literal: true

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test 'creates task' do
    task = create :task
    assert task
    assert_equal 1, task.number
  end
end
