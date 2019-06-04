class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.references :owner, foreign_key: { to_table: :users }
      t.string :name, null: false

      t.timestamps
    end
  end
end
