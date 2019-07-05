# frozen_string_literal: true

module CommentsHelper
  def task_comments_block(task)
    react_component 'Comments', {
      taskId: task.id,
      currentUser: { fullName: current_user.public_name, avatarUrl: current_user.avatar_url },
    }, predender: true
  end
end
