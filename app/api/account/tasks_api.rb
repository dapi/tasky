# frozen_string_literal: true

class Account::TasksAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  resources :tasks do
    params do
      optional_metadata_query
      optional_include TaskSerializer
    end
    get do
      present TaskSerializer.new by_metadata(current_account.tasks.ordered), include: jsonapi_include
    end

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
      delete do
        current_task.destroy!

        :success
      end

      resources :attachments do
        desc 'Create the attachment'
        params do
          requires :files, type: Array[Rack::Multipart::UploadedFile]
        end
        post do
          attachments = params.fetch(:files, []).map do |file|
            current_task.attachments.create!(
              user: current_user,
              file: file
            )
            current_task.notify
          end

          present TaskAttachmentSerializer.new attachments
        end
      end
    end
  end
end
