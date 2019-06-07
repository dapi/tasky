# frozen_string_literal: true

class CreateLanes < ActiveRecord::Migration[5.2]
  def change
    create_table :lanes, id: :uuid do |t|
      t.references :board, foreign_key: true, null: false, type: :uuid, index: true
      t.string :title, null: false
      t.integer :stage, null: false, default: 0
      t.integer :position, null: false

      t.timestamps
    end

    add_index :lanes, %i[board_id title], unique: true

    add_index :lanes, %i[board_id position], unique: true
  end
end
