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

      TaskHistory.new(task).create_task
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
        TaskHistory.new(current_task).remove_task current_user
        current_task.destroy!

        :success
      end

      resources :attachments do
        params do
          requires :files, type: Array[Rack::Multipart::UploadedFile]
        end
        post do
          attachments = params.fetch(:files, []).map do |file|
            attachment = current_task.attachments.create!(
              user: current_user,
              file: file
            )
            TaskHistory.new(current_task).add_attachment attachment
            TaskNotifyJob.perform_later current_task.id
            attachment
          end
          present TaskAttachmentSerializer.new attachments
        end

        resource ':attachment_id' do
          delete do
            attachment = current_task.attachments.find params[:attachment_id]
            attachment.destroy!

            TaskHistory.new(current_task).remove_attachment current_user, attachment
            TaskNotifyJob.perform_later current_task.id
            :success
          end
        end
      end
    end
  end
end
