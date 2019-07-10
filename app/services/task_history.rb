# frozen_string_literal: true

class TaskHistory
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::NumberHelper

  def initialize(task)
    @task = task
  end

  def move_across_lanes(user, from_lane, to_lane)
    create_comment(
      :move_across_lanes,
      user: user,
      args: { from_lane: from_lane.title, to_lane: to_lane.title },
      metadata: { from_lane_id: from_lane.id, to_lane_id: to_lane.id }
    )
  end

  def create_task
    # Disallow as it is increments comments_count and every task
    # has comments badge at start
    return unless ENV['HISTORY_CREATE_TASK']

    create_comment(
      :create_task,
      user: task.author,
      args: { user: user_link(task.author) }
    )
  end

  def remove_task(user)
    create_comment(
      :remove_task,
      user: user,
      args: { user: user_link(user) }
    )
  end

  def add_attachment(attachment)
    create_comment(
      :add_attachment,
      user: attachment.user,
      args: { file: link_to_file(attachment) },
      metadata: { task_attachment: present_task_attachment(attachment) }
    )
  end

  def remove_attachment(user, attachment)
    create_comment(
      :remove_attachment,
      user: user,
      args: { file: attachment_details(attachment) },
      metadata: { task_attachment: present_task_attachment(attachment) }
    )
  end

  private

  attr_reader :task

  def create_comment(action, user:, args: {}, metadata: {})
    comment = task.comments.create!(
      is_robot: true,
      author_id: user.id,
      content: t(action, args),
      metadata: metadata.merge(action: action)
    )
    notify_comment comment
  end

  def user_link(user)
    link_to user.public_nickname, '#', data: { mention: user.public_nickname, userId: user.id }
  end

  def present_task_attachment(attachment)
    TaskAttachmentSerializer.new(attachment).as_json
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
