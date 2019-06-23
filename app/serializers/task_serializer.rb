# frozen_string_literal: true

class TaskSerializer
  include FastJsonapi::ObjectSerializer
  set_type :task

  belongs_to :author, record_type: :user, serializer: :User
  has_many :cards
  has_many :comments, record_type: :task_comment, serializer: :TaskComment

  attributes :title, :details, :formatted_details, :comments_count, :metadata
end
