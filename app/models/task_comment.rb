# frozen_string_literal: true

class TaskComment < ApplicationRecord
  nilify_blanks

  belongs_to :task, counter_cache: :comments_count
  belongs_to :author, class_name: 'User'
  has_one :account, through: :task

  has_many :cards, through: :task
  has_many :boards, through: :cards

  scope :ordered, -> { order 'created_at desc' }
  scope :unseen_by, ->(user_id) { where 'not (readers_ids @> ARRAY[?::uuid])', user_id }

  after_commit :touch_task

  before_destroy :unset_task_last_comment

  validates :content, presence: true

  def mark_as_seen!(user_id)
    self.class.connection.update(<<-SQL)
    update task_comments set readers_ids = readers_ids || ARRAY[ #{ActiveRecord::Base.connection.quote(user_id)}::uuid ] where id=#{ActiveRecord::Base.connection.quote(id)}
    SQL
    reload
  end

  def formatted_content
    Kramdown::Document
      .new(content.to_s, input: 'GFM', syntax_highlighter: :coderay, syntax_highlighter_opts: { line_numbers: false })
      .to_html
      .chomp
      .html_safe
  end

  private

  def touch_task
    task.update last_comment_id: id, last_comment_at: created_at
  end

  def unset_task_last_comment
    last_comment = task.comments.ordered.where.not(id: id).last
    task.update last_comment_id: last_comment.try(:id), last_comment_at: last_comment.try(:created_at)
  end
end
