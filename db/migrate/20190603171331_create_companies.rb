# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.references :owner, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :companies, %i[owner_id name], unique: true
    add_index :companies, :slug, unique: true
  end
end
