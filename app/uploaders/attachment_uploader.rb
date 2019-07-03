# frozen_string_literal: true

# Task attachments file
#
class AttachmentUploader < ApplicationUploader
  def store_dir
    "#{model.account.id}/tasks/#{model.id}"
  end

  # You can find a full list of custom headers in AWS SDK documentation on
  # AWS::S3::S3Object
  def download_url(filename)
    url(response_content_disposition: %(attachment; filename="#{filename}"))
  end
end
