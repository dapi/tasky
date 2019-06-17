# frozen_string_literal: true

module CommentsHelper
  def task_comments_block(task)
    react_component 'Comments', {
      account: { id: current_account.id },
      task: { id: task.id },
      user: { fullName: current_user.public_name, avatarUrl: avatar_url(current_user) },
      comments: present_comments(task.comments.includes(:author).ordered)
    }, predender: true
  end

  private

  def avatar_url(email)
    email = email.email if email.respond_to?(:email)
    gravatar_attrs(email, default: :monsterid)[:src]
  end

  # an example:
  # https://github.com/lesha1201/simple-react-comments/blob/master/preview/data/index.ts
  def present_comments(comments)
    comments.map do |comment|
      {
        id: comment.id,
        avatarUrl: avatar_url(comment.author),
        createdAt: comment.created_at,
        fullName: comment.author.public_name,
        text: comment.content
      }
    end
  end
end
