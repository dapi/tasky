# frozen_string_literal: true

class AddContentTypeToTaskAttachments < ActiveRecord::Migration[5.2]
  def change
    add_column :task_attachments, :content_type, :string, null: false
  end
end
