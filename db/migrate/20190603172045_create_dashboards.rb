# frozen_string_literal: true

class CreateDashboards < ActiveRecord::Migration[5.2]
  def change
    create_table :dashboards do |t|
      t.string :title, null: false
      t.references :company, foreign_key: true, null: false
      t.references :owner, foreign_key: { to_table: :users }, null: false
      t.integer :lanes_count, null: false, default: 0

      t.timestamps
    end

    add_index :dashboards, %i[company_id title], unique: true
  end
end
