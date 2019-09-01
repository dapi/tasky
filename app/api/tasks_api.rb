# frozen_string_literal: true

class TasksAPI < Grape::API
  content_type :jsonapi, 'application/vnd.api+json'
  format :jsonapi
  formatter :jsonapi, Grape::Formatter::SerializableHash

  helpers do
    def account
      @account ||= current_user.accounts.find params[:account_id]
    end
  end

  resources :tasks do
    params do
      requires :account_id, type: String
      optional_metadata_query
      optional_include TaskSerializer
    end
    get do
      present TaskSerializer.new by_metadata(account.tasks.ordered), include: jsonapi_include
    end

    params do
      requires :account_id, type: String
      requires :title, type: String
      optional :details, type: String
      optional_metadata
    end
    post do
      task = account.tasks.create!(
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
          @current_task ||= current_user.available_tasks.find(params[:task_id])
        end
      end
      delete do
        TaskHistory.new(current_task).remove_task current_user
        current_task.destroy!

        :success
      end

      resources :comments do
        params do
          requires :content, type: String
          optional :id, type: String, desc: 'task_comment id if exists'
        end
        post do
          task_comment = current_task.comments.create! declared(params, include_missing: false).merge(author: current_user)

          TaskCommentNotifyJob.perform_later task_comment.id
          present TaskCommentSerializer.new task_comment
        end

        params do
          optional_include TaskCommentSerializer
        end
        get do
          comments = current_task.comments.ordered.includes(:author)
          present TaskCommentSerializer.new comments, include: jsonapi_include
        end
      end
      resource :seen do
        desc 'Mark this task as seen by current user'
        params do
          requires :seen_at, type: Time, desc: 'Timestamp of last seen comment'
        end
        put do
          TaskSeen.new(current_task, current_user).mark_as_seen! params[:seen_at]
          :success
        end
      end

      resources :attachments do
        params do
          requires :files, type: Array[Rack::Multipart::UploadedFile], documentation: { type: :array, item: :file }
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
