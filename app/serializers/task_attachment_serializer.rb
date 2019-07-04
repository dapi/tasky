# frozen_string_literal: true

class TaskAttachmentSerializer
  include FastJsonapi::ObjectSerializer
  set_type :task_attachment

  belongs_to :user
  belongs_to :task

  attributes :created_at, :url, :original_filename, :details, :file_size
end
