# frozen_string_literal: true

class CreateLanes < ActiveRecord::Migration[5.2]
  def change
    create_table :lanes do |t|
      t.references :dashboard, foreign_key: true, null: false
      t.string :title, null: false
      t.integer :cards_count, null: false, default: 0

      t.timestamps
    end
  end
end
