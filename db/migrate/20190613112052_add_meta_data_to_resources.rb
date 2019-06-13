# frozen_string_literal: true

class AddMetaDataToResources < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :metadata, :jsonb, null: false, default: {}
    add_column :boards, :metadata, :jsonb, null: false, default: {}
    add_column :lanes, :metadata, :jsonb, null: false, default: {}
    add_column :tasks, :metadata, :jsonb, null: false, default: {}
  end
end
