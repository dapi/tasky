# frozen_string_literal: true

# rubocop:disable Rails/ReversibleMigration
class AddBoardAndTasksToInvites < ActiveRecord::Migration[5.2]
  def change
    enable_extension :citext

    add_column :invites, :board_id, :uuid
    add_column :invites, :task_id, :uuid
    add_foreign_key :invites, :boards
    add_foreign_key :invites, :tasks

    drop_table :board_invites

    # citext - case insensitive string
    change_column :invites, :email, :citext
    change_column :users, :email, :citext

    remove_column :invites, :invitee_id

    remove_index :invites, :email

    add_index :invites, %i[email board_id task_id], unique: true
  end
end
# rubocop:enable Rails/ReversibleMigration
