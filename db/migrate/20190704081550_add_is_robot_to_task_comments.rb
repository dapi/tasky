# frozen_string_literal: true

class AddIsRobotToTaskComments < ActiveRecord::Migration[5.2]
  def change
    add_column :task_comments, :is_robot, :boolean, null: false, default: false
    add_column :task_comments, :metadata, :jsonb, null: false, default: {}
  end
end
