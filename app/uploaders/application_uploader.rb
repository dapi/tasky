# frozen_string_literal: true

class ApplicationUploader < CarrierWave::Uploader::Base
  include SecureUniqueFilename
  include FileDetails

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:

  def store_dir
    "#{prefix_dir}#{model.account.id}/#{model.class.model_name.collection}/#{model.id}/#{mounted_as}"
  end

  private

  def prefix_dir
    return Rails.env + '/' unless Rails.env.production?
  end
end
