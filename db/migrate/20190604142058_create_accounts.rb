# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts, id: :uuid do |t|
      t.references :owner, foreign_key: { to_table: :users }, type: :uuid, index: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
