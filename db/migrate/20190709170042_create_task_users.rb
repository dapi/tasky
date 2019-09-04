# frozen_string_literal: true

class CreateTaskUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :task_users, id: :uuid do |t|
      t.references :task, foreign_key: true, null: false, type: :uuid
      t.references :user, foreign_key: true, null: false, type: :uuid
      t.timestamp :seen_at, null: false
    end

    add_index :task_users, %i[task_id user_id], unique: true
  end
end
