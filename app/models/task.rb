# frozen_string_literal: true

class Task < ApplicationRecord
  include Archivable
  include MetadataSupport

  belongs_to :author, class_name: 'User'
  belongs_to :account

  has_many :comments, class_name: 'TaskComment', dependent: :delete_all

  def formatted_details
    Kramdown::Document
      .new(details, input: 'GFM', syntax_highlighter: :coderay, syntax_highlighter_opts: { line_numbers: false })
      .to_html
      .html_safe
  end
end
