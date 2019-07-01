# frozen_string_literal: true

require 'test_helper'

class TaskCommentsAPITest < ActionDispatch::IntegrationTest
  setup do
    login_user
    account_host!
  end

  test 'POST /api/v1/task_comments' do
    task = create :task, account: @current_account
    content = generate :details
    post '/api/v1/task_comments', params: { content: content, task_id: task.id }
    assert response.successful?
    assert task.reload.comments.any?
  end
end
