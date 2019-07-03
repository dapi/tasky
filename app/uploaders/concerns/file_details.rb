# frozen_string_literal: true

module FileDetails
  extend ActiveSupport::Concern
  included do
    include ActionView::Helpers::NumberHelper

    after :cache, :save_file_size
  end

  def details
    if file.present?
      "#{number_to_human_size file.size} (.#{file.extension})"
    else
      'no file exists!'
    end
  end

  private

  def save_file_size(_file)
    return unless model.respond_to? :file_size=

    model.file_size = file.present? ? file.size : nil
  end
end
