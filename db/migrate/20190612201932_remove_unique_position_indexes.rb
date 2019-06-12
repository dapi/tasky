# frozen_string_literal: true

class RemoveUniquePositionIndexes < ActiveRecord::Migration[5.2]
  def change
    remove_index :tasks, %i[lane_id position]
    add_index :tasks, %i[lane_id position]

    remove_index :lanes, %i[board_id position]
    add_index :lanes, %i[board_id position]
  end
end
