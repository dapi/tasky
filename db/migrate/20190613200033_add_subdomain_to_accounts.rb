# frozen_string_literal: true

class AddSubdomainToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :subdomain, :string, length: 64 # rubocop:disable Rails/BulkChangeTable

    Account.find_each do |a|
      a.update subdomain: SecureRandom.hex(4)
    end

    change_column_null :accounts, :subdomain, false

    add_index :accounts, :subdomain, unique: true
  end
end
