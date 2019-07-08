# frozen_string_literal: true

require 'test_helper'

class TaskCommentTest < ActiveSupport::TestCase
  test 'update readers_ids' do
    comment = create :task_comment
    user = create :user

    comment.mark_as_seen! user.id

    assert_includes comment.readers_ids, user.id
  end

  test 'touch task' do
    comment = create :task_comment

    assert_equal comment.task.last_comment_id, comment.id
    assert_equal comment.task.last_comment_at, comment.created_at
  end
end
