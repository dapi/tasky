# frozen_string_literal: true

class CreateBoardMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :board_memberships do |t|
      t.references :board, foreign_key: true, null: false
      t.references :member, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end

    add_index :board_memberships, %i[board_id member_id], unique: true
  end
end
