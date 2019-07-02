# frozen_string_literal: true

class AddIsPersonalToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :is_personal, :boolean, null: false, default: false

    add_index :accounts, %i[owner_id is_personal], unique: true, where: 'is_personal=true'

    User.find_each do |user|
      if user.owned_accounts.any?
        user.owned_accounts.first.update is_personal: true
      else
        user.send(:create_personal_account!)
      end
    end
  end
end
