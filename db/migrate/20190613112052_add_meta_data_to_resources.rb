# frozen_string_literal: true

class AddMetaDataToResources < ActiveRecord::Migration[5.2]
  def up
    add_column :accounts, :metadata, :jsonb, null: false, default: {}
    add_column :boards, :metadata, :jsonb, null: false, default: {}
    add_column :lanes, :metadata, :jsonb, null: false, default: {}
    add_column :tasks, :metadata, :jsonb, null: false, default: {}

    add_index :accounts, :metadata, using: :gin
    add_index :boards, :metadata, using: :gin
    add_index :lanes, :metadata, using: :gin
    add_index :tasks, :metadata, using: :gin
  end

  def down
    remove_column :accounts, :metadata
    remove_column :boards, :metadata
    remove_column :lanes, :metadata
    remove_column :tasks, :metadata
  end
end
