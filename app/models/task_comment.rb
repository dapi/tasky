# frozen_string_literal: true

class TaskComment < ApplicationRecord
  nilify_blanks

  belongs_to :task, counter_cache: :comments_count
  belongs_to :author, class_name: 'User'
  has_one :account, through: :task

  has_many :cards, through: :task
  has_many :boards, through: :cards

  scope :ordered, -> { order 'created_at desc' }

  validates :content, presence: true

  def formatted_content
    Kramdown::Document
      .new(content.to_s, input: 'GFM', syntax_highlighter: :coderay, syntax_highlighter_opts: { line_numbers: false })
      .to_html
      .chomp
      .html_safe
  end
end
