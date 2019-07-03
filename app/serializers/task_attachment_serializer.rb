# frozen_string_literal: true

class TaskAttachmentSerializer
  include FastJsonapi::ObjectSerializer
  set_type :task_attach

  belongs_to :user
  belongs_to :task

  attributes :created_at, :url, :original_filename, :details, :file_size
end
