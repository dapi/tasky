# frozen_string_literal: true

module FileDetails
  extend ActiveSupport::Concern
  included do
    include ActionView::Helpers::NumberHelper

    after :cache, :save_details
  end

  def details
    if file.present?
      "#{number_to_human_size file.size} (.#{file.extension})"
    else
      'no file exists!'
    end
  end

  private

  def save_details(_file)
    model.original_filename = original_filename if model.respond_to? :original_filename=
    model.file_size = file.present? ? file.size : nil if model.respond_to? :file_size=
  end
end
