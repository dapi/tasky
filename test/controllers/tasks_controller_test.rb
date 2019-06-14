# frozen_string_literal: true

require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  def setup
    login_user
  end

  test 'should get edit' do
    task = create :task
    get edit_task_url(task, subdomain: task.account.subdomain)
    assert_response :success
  end
end
