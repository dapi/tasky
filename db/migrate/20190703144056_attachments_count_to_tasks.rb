# frozen_string_literal: true

class AttachmentsCountToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :attachments_count, :integer, null: false, default: 0
  end
end
