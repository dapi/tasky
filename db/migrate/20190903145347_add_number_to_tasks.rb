# frozen_string_literal: true

class AddNumberToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :number, :integer

    Account.find_each do |a|
      number = 0
      a.tasks.order(:created_at).each do |t|
        t.update_column :number, number += 1
      end
    end

    change_column :tasks, :number, :integer, null: false
    add_index :tasks, %i[account_id number], unique: true
  end
end
