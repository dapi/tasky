class CreateMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :memberships do |t|
      t.references :user, foreign_key: true, null: false
      t.references :company, foreign_key: true, null: false
      t.integer :role, null: false, default: 0

      t.timestamps
    end

    add_index :memberships, [:company_id, :user_id]
  end
end
