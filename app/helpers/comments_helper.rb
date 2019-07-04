# frozen_string_literal: true

module CommentsHelper
  def task_comments_block(task)
    react_component 'Comments', {
      account: { id: current_account.id },
      task: { id: task.id },
      user: { fullName: current_user.public_name, avatarUrl: current_user.avatar_url },
      comments: present_comments(task.comments.includes(:author).ordered)
    }, predender: true
  end

  private

  # an example:
  # https://github.com/lesha1201/simple-react-comments/blob/master/preview/data/index.ts
  def present_comments(comments)
    comments.map do |comment|
      {
        id: comment.id,
        avatarUrl: comment.author.avatar_url,
        createdAt: comment.created_at,
        fullName: comment.author.public_name,
        text: comment.formatted_content
      }
    end
  end
end
