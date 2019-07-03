# frozen_string_literal: true

class CreateTaskAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :task_attachments, id: :uuid do |t|
      t.references :task, foreign_key: true, type: :uuid, null: false
      t.references :user, foreign_key: true, type: :uuid, null: false
      t.string :file, null: false
      t.integer :file_size, null: false

      t.timestamps
    end
  end
end
