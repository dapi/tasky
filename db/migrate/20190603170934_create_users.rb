# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'pg_buffercache'
    enable_extension 'pgcrypto'
    enable_extension 'uuid-ossp'

    create_table :users, id: :uuid do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :access_key, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :access_key, unique: true
  end
end
