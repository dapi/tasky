# frozen_string_literal: true

class Account::TasksAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  resources :tasks do
    desc 'Список задач'
    params do
      optional_metadata_query
      optional_include TaskSerializer
    end
    get do
      present TaskSerializer.new by_metadata(current_account.tasks.ordered), include: jsonapi_include
    end

    desc 'Добавить задачу'
    params do
      requires :title, type: String
      optional :details, type: String
      optional_metadata
    end
    post do
      task = current_account.tasks.create!(
        title: params[:title] || 'Без названия',
        details: params[:details],
        author: current_user,
        metadata: parsed_metadata
      )

      present TaskSerializer.new task
    end

    params do
      requires :task_id, type: String
    end
    namespace ':task_id' do
      helpers do
        def current_task
          @current_task ||= current_account.tasks.find(params[:task_id])
        end
      end
      desc 'Удалить задачу'
      delete do
        current_task.destroy!

        :success
      end
    end
  end
end
