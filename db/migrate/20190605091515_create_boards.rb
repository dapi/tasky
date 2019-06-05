# frozen_string_literal: true

class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.references :account, foreign_key: true, null: false
      t.string :title, null: false

      t.timestamps
    end

    add_index :boards, %i[account_id title], unique: true
  end
end
