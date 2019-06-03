# frozen_string_literal: true

class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.references :lane, foreign_key: true, null: false
      t.references :author, foreign_key: { to_table: :users }, null: false
      t.string :title
      t.text :details
      t.json :meta

      t.timestamps
    end
  end
end
