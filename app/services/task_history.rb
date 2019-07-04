# frozen_string_literal: true

class TaskHistory
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::NumberHelper

  def initialize(task)
    @task = task
  end

  def add_attachment(attachment)
    comment = task.comments.create!(
      is_robot: true,
      author_id: attachment.user_id,
      content: t(:add_attachment, user: user_link(attachment.user), file: link_to_file(attachment)),
      metadata: {
        type: :add_attachment,
        task_attachment_id: attachment.id,
        task_attachment: present_task_attachment(attachment)
      }
    )
    notify_comment comment
  end

  def remove_attachment(user, attachment)
    comment = task.comments.create!(
      is_robot: true,
      author_id: user.id,
      content: t(:remove_attachment, user: user_link(user), file: attachment_details(attachment)),
      metadata: {
        type: :remove_attachment,
        task_attachment_id: attachment.id,
        task_attachment: present_task_attachment(attachment)
      }
    )
    notify_comment comment
  end

  private

  attr_reader :task

  def user_link(user)
    link_to user.public_nickname, '#', data: { mention: user.public_nickname, userId: user.id }
  end

  def present_task_attachment(attachment)
    TaskAttachmentSerializer.new(attachment).as_json['data']['attributes']
  end

  def link_to_file(attachment)
    link_to attachment_details(attachment), attachment.url, target: '_blank', rel: 'noopener'
  end

  def attachment_details(attachment)
    "#{attachment.original_filename} (#{number_to_human_size attachment.file_size, precision: 2})"
  end

  def notify_comment(comment)
    TaskCommentNotifyJob.perform_later comment.id
  end

  def t(key, options = {})
    I18n.t key, options.merge(scope: [:task_history])
  end
end
