# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
class TaskHistory
  def initialize(task)
    @task = task
  end

  def add_attachment(attachment)
    comment = task.comments.create!(
      is_robot: true,
      author_id: attachment.user_id,
      content: t(:add_attachment, user: attachment.user.nickname, file: attachment.original_filename),
      metadata: {
        task_attachment_id: attachment.id,
        task_attachment: TaskAttachmentSerializer.new(TaskAttachment.last).as_json['data']['attributes']
      }
    )
    notify_comment comment
  end

  private

  attr_reader :task

  def notify_comment(comment)
    TaskCommentNotifyJob.perform_later comment.id
  end

  def t(key, options = {})
    I18n.t key, options.merge(scope: [:task_history])
  end
end
# rubocop:enable Metrics/AbcSize
