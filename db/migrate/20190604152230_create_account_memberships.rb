# frozen_string_literal: true

class CreateAccountMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :account_memberships, id: :uuid do |t|
      t.references :member, foreign_key: { to_table: :users }, null: false, type: :uuid, index: true
      t.references :account, foreign_key: true, null: false, type: :uuid, index: true

      t.timestamps
    end

    add_index :account_memberships, %i[account_id member_id], unique: true
  end
end
