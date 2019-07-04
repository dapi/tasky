# frozen_string_literal: true

class AddOriginalFilenameToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :task_attachments, :original_filename, :string, null: false
  end
end
