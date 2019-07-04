# frozen_string_literal: true

module TaskHelper
  def task_attachments(task)
    react_component(
      'TaskAttachments',
      taskId: task.id,
      attachments: TaskAttachmentSerializer.new(task.attachments.ordered).as_json['data']
    )
  end
end
