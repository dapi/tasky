# frozen_string_literal: true

class Task < ApplicationRecord
  include Archivable
  include MetadataSupport

  belongs_to :author, class_name: 'User'
  belongs_to :account

  has_many :comments, class_name: 'TaskComment', dependent: :delete_all

  def formatted_details
    m = Redcarpet::Markdown.new Redcarpet::Render::HTML, autolink: true, tables: true
    m.render details
  end
end
