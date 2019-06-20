# frozen_string_literal: true

class Public::TaskCommentsAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  before do
    authorize_user!
  end

  desc 'Комментарии к задачам'

  params do
    requires :task_id, type: String
  end
  resources :tasks do
    resource ':task_id' do
      helpers do
        def current_task
          @current_task ||= current_user.available_tasks.find(params[:task_id])
        end
      end

      resources :comments do
        desc 'Добавить комментарий'

        params do
          requires :content, type: String, desc: 'Содержимое комментария'
          optional :id, type: String, desc: 'ID комментария если есть'
        end
        post do
          task_comment = current_task.comments.create! declared(params, include_missing: false).merge(author: current_user)

          present TaskCommentSerializer.new task_comment
        end
      end
    end
  end
end
