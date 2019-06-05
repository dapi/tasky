# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :lane, foreign_key: true, null: false
      t.references :author, foreign_key: { to_table: :users }, null: false
      t.integer :position, null: false
      t.string :title, null: false
      t.text :detail
      t.timestamp :completed_at
      t.date :deadline_date
      t.date :deadline_time

      t.timestamps
    end

    add_index :tasks, %i[lane_id position], unique: true
  end
end
