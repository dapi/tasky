# frozen_string_literal: true

class CreateTaskComments < ActiveRecord::Migration[5.2]
  def change
    create_table :task_comments, id: :uuid do |t|
      t.references :task, foreign_key: true, null: false, type: :uuid
      t.references :author, foreign_key: { to_table: :users }, null: false, type: :uuid
      t.string :content, null: false

      t.timestamps
    end

    add_index :task_comments, %i[task_id created_at]
  end
end
