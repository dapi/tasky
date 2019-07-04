# frozen_string_literal: true

class AddNicknameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname, :citext
    add_index :users, :nickname, unique: true
  end
end
