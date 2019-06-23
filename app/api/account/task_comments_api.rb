# frozen_string_literal: true

class Account::TaskCommentsAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  desc 'Комментарии к задачам'

  helpers do
    def current_task
      @current_task ||= current_account.tasks.find(params[:task_id])
    end
  end

  resources :task_comments do
    desc 'Добавить комментарий'

    params do
      requires :content, type: String, desc: 'Содержимое комментария'
      requires :task_id, type: String
      optional :id, type: String, desc: 'ID комментария если есть'
    end
    post do
      task_comment = current_task.comments.create! declared(params, include_missing: false).merge(author: current_user)

      present TaskCommentSerializer.new task_comment
    end
  end
end
