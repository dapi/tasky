# frozen_string_literal: true

class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites, id: :uuid do |t|
      t.references :account, foreign_key: true, null: false, type: :uuid, index: true
      t.references :inviter, foreign_key: { to_table: :users }, null: false, type: :uuid, index: true
      t.string :email, null: false
      t.references :invitee, foreign_key: { to_table: :users }, type: :uuid, index: true

      t.timestamps
    end

    add_index :invites, :email, unique: true
  end
end
