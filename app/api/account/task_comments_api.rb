# frozen_string_literal: true

# TODO: Move to tasks api
class Account::TaskCommentsAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  helpers do
    def current_task
      @current_task ||= current_account.tasks.find(params[:task_id])
    end
  end

  resources :task_comments do
    params do
      requires :task_id, type: String
      requires :content, type: String
      optional :id, type: String, desc: 'task_comment id if exists'
    end
    post do
      task_comment = current_task.comments.create! declared(params, include_missing: false).merge(author: current_user)

      task_comment.boards.find_each(&:notify)

      current_task.notify
      present TaskCommentSerializer.new task_comment
    end
  end
end
