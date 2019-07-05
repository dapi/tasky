# frozen_string_literal: true

class TaskAttachment < ApplicationRecord
  belongs_to :task, counter_cache: :attachments_count
  belongs_to :user
  has_one :account, through: :task

  scope :ordered, -> { order :created_at }

  mount_uploader :file, AttachmentUploader

  validates :file, presence: true

  delegate :url, :details, to: :file
end
