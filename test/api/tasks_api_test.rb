# frozen_string_literal: true

require 'test_helper'

class TasksAPITest < ActionDispatch::IntegrationTest
  setup do
    login_user
    @current_account = create :account, owner: @current_user
  end

  test 'GET /api/v1/tasks' do
    create :task, account: @current_account
    get '/api/v1/tasks', params: { account_id: @current_account.id }
    assert response.successful?
    assert_equal 1, JSON.parse(response.body)['data'].count
  end

  test 'POST /api/v1/tasks' do
    title = generate :title
    post '/api/v1/tasks', params: { title: title, account_id: @current_account.id }
    assert response.successful?
    assert @current_account.tasks.one?
  end

  test 'DELETE /api/v1/tasks/:id' do
    task = create :task, account: @current_account
    delete "/api/v1/tasks/#{task.id}"
    assert response.successful?
    assert_raise ActiveRecord::RecordNotFound do
      task.reload
    end
  end

  test 'POST /api/v1/tasks/:id/comments' do
    task = create :task, account: @current_account
    post "/api/v1/tasks/#{task.id}/comments", params: { content: generate(:details), account_id: @current_account.id }
    assert response.successful?
    assert task.reload.comments.any?
  end
end
