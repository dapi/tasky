# frozen_string_literal: true

class TaskAttachment < ApplicationRecord
  belongs_to :task, counter_cache: :attachments_count
  belongs_to :user
  has_one :account, through: :task

  scope :ordered, -> { order :created_at }

  mount_uploader :file, AttachmentUploader

  after_commit on: :create do
    TaskHistory.new(task).add_attachment self
  end

  delegate :url, :details, to: :file
end
