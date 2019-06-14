# frozen_string_literal: true

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test 'creates task' do
    task = create :task
    assert task
  end
end
