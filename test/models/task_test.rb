# frozen_string_literal: true

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test 'creates task' do
    task = create :task
    assert task
  end

  test 'safety auto generate unique task numbers' do
    account = create :account
    count = 50

    threads = []
    count.times do
      threads << Thread.new do
        create :task, account: account
      end
    end

    threads.each(&:join)

    assert count, account.tasks.maximum(:number)
  end
end
