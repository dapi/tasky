# frozen_string_literal: true

class Task < ApplicationRecord
  include Archivable
  include MetadataSupport

  belongs_to :author, class_name: 'User'
  belongs_to :account

  has_many :cards, dependent: :delete_all
  has_many :comments, class_name: 'TaskComment', dependent: :delete_all

  after_update do
    cards.find_each(&:touch)
  end

  def formatted_details
    Kramdown::Document
      .new(details.to_s, input: 'GFM', syntax_highlighter: :coderay, syntax_highlighter_opts: { line_numbers: false })
      .to_html
      .chomp
      .html_safe
  end
end
