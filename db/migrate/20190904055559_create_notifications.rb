# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications, id: :uuid do |t|
      t.references :user, foreign_key: :true, type: :uuid, null: false
      t.string :key, null: false
      t.jsonb :payload, null: false, default: {}
      t.timestamp :read_at
      t.datetime :created_at, null: false
    end

    add_index :notifications, :user_id, where: 'read_at is null', name: 'index_notifications_on_read_user'
  end
end
