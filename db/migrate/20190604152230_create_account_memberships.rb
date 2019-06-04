class CreateAccountMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :account_memberships do |t|
      t.references :user, foreign_key: true, null: false
      t.references :account, foreign_key: true, null: false

      t.timestamps
    end

    add_index :account_memberships, [:account_id, :user_id], unique: true
  end
end
