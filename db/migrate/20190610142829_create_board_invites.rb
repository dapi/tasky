# frozen_string_literal: true

class CreateBoardInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :board_invites, id: :uuid do |t|
      t.references :board, foreign_key: true, null: false, type: :uuid
      t.references :invite, foreign_key: true, null: false, type: :uuid
      t.references :inviter, foreign_key: { to_table: :users }, null: false, type: :uuid

      t.timestamps
    end

    add_index :board_invites, %i[board_id invite_id], unique: true
  end
end
