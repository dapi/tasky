# frozen_string_literal: true

class AddUniqueIndexToPositions < ActiveRecord::Migration[5.2]
  def change
    remove_index :lanes, %i[board_id position]

    add_index :lanes, %i[board_id position], unique: true
    add_index :cards, %i[lane_id position], unique: true
  end
end
