# frozen_string_literal: true

class CreateLanes < ActiveRecord::Migration[5.2]
  def change
    create_table :lanes do |t|
      t.references :board, foreign_key: true, null: false
      t.string :title, null: false
      t.integer :stage, null: false, default: 0
      t.integer :position, null: false

      t.timestamps
    end

    add_index :lanes, %i[board_id title], unique: true
    add_index :lanes, %i[board_id stage], unique: true, where: 'stage=0', name: 'index_lanes_on_board_id_and_stage_0'
    add_index :lanes, %i[board_id stage], unique: true, where: 'stage=2', name: 'index_lanes_on_board_id_and_stage_2'

    add_index :lanes, %i[board_id position], unique: true
  end
end
