# frozen_string_literal: true

class TaskCommentSerializer
  include FastJsonapi::ObjectSerializer
  set_type :task_comment

  belongs_to :author, record_type: :user, serializer: :User
  belongs_to :task

  attributes :created_at, :content, :formatted_content, :author_id, :readers_ids
end
