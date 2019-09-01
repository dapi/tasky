# frozen_string_literal: true

class RemoveSubdomainFromAccounts < ActiveRecord::Migration[5.2]
  def up
    remove_column :accounts, :subdomain
  end

  def down
    add_column :accounts, :subdomain
    add_index :accounts, :subdomain, unique: true
  end
end
