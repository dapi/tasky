# frozen_string_literal: true

class AddSecretTokenToInvites < ActiveRecord::Migration[5.2]
  def change
    add_column :invites, :token, :string, null: false
    add_column :board_invites, :token, :string, null: false

    add_index :invites, :token, unique: true
    add_index :board_invites, :token, unique: true
  end
end
