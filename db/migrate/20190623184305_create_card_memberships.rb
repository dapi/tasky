# frozen_string_literal: true

class CreateCardMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :card_memberships, id: :uuid do |t|
      t.references :card, foreign_key: true, null: false, type: :uuid
      t.references :account_membership, foreign_key: true, null: false, type: :uuid, index: true

      t.timestamps
    end

    add_index :card_memberships, %i[card_id account_membership_id], unique: true
  end
end
