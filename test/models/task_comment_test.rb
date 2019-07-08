# frozen_string_literal: true

require 'test_helper'

class TaskCommentTest < ActiveSupport::TestCase
  test 'update readers_ids' do
    comment = create :task_comment
    user = create :user

    comment.mark_as_seen! user.id

    assert_includes comment.readers_ids, user.id
  end
end
