# frozen_string_literal: true

class TaskAttachment < ApplicationRecord
  belongs_to :task, counter_cache: :attachments_count
  belongs_to :user
  has_one :account, through: :task

  mount_uploader :file, AttachmentUploader

  delegate :url, to: :file
end
