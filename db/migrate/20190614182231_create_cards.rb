# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
class CreateCards < ActiveRecord::Migration[5.2]
  def up
    create_table :cards, id: :uuid do |t|
      t.references :board, foreign_key: true, type: :uuid, null: false
      t.references :lane, foreign_key: true, type: :uuid, null: false
      t.references :task, foreign_key: true, type: :uuid, null: false
      t.integer :position, null: false
      t.timestamp :archived_at

      t.timestamps
    end

    add_index :cards, %i[board_id task_id], unique: true
    add_index :cards, %i[lane_id task_id], unique: true

    Task.find_each do |task|
      Card.create!(task: task, lane_id: task.lane_id, board: Lane.find(task.lane_id).board, position: task.position)
    end

    remove_column :tasks, :lane_id
    remove_column :tasks, :position
    add_column :tasks, :account_id, :uuid, null: false
    add_foreign_key :tasks, :accounts
  end
end
# rubocop:enable Metrics/AbcSize
