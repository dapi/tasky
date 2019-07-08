# frozen_string_literal: true

class AddReadUserIdsToComments < ActiveRecord::Migration[5.2]
  def change
    # ID list of users that have seen this comment
    add_column :task_comments, :readers_ids, :uuid, null: false, default: [], array: true

    add_index :task_comments, %i[task_id readers_ids]
  end
end
