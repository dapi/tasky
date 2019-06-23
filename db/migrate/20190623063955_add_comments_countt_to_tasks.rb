# frozen_string_literal: true

class AddCommentsCounttToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :comments_count, :integer, null: false, default: 0
  end
end
