# frozen_string_literal: true

# Task attachments file
#
class AttachUploaderUploader < ApplicationAploader
  def store_dir
    "#{model.account.id}/tasks/#{model.id}"
  end
end
