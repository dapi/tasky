# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :access_key, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :access_key, unique: true
  end
end
