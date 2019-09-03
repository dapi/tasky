# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_02_170126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pg_buffercache"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "account_memberships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "member_id", null: false
    t.uuid "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "member_id"], name: "index_account_memberships_on_account_id_and_member_id", unique: true
    t.index ["account_id"], name: "index_account_memberships_on_account_id"
    t.index ["member_id"], name: "index_account_memberships_on_member_id"
  end

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "owner_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "metadata", default: {}, null: false
    t.datetime "archived_at"
    t.boolean "is_personal", default: false, null: false
    t.index ["metadata"], name: "index_accounts_on_metadata", using: :gin
    t.index ["name"], name: "index_accounts_on_name"
    t.index ["owner_id", "is_personal"], name: "index_accounts_on_owner_id_and_is_personal", unique: true, where: "(is_personal = true)"
    t.index ["owner_id"], name: "index_accounts_on_owner_id"
  end

  create_table "board_memberships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "board_id", null: false
    t.uuid "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id", "member_id"], name: "index_board_memberships_on_board_id_and_member_id", unique: true
    t.index ["board_id"], name: "index_board_memberships_on_board_id"
    t.index ["member_id"], name: "index_board_memberships_on_member_id"
  end

  create_table "boards", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "account_id", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "metadata", default: {}, null: false
    t.datetime "archived_at"
    t.index ["account_id"], name: "index_boards_on_account_id"
    t.index ["metadata"], name: "index_boards_on_metadata", using: :gin
  end

  create_table "card_memberships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "card_id", null: false
    t.uuid "account_membership_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_membership_id"], name: "index_card_memberships_on_account_membership_id"
    t.index ["card_id", "account_membership_id"], name: "index_card_memberships_on_card_id_and_account_membership_id", unique: true
    t.index ["card_id"], name: "index_card_memberships_on_card_id"
  end

  create_table "cards", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "board_id", null: false
    t.uuid "lane_id", null: false
    t.uuid "task_id", null: false
    t.integer "position", null: false
    t.datetime "archived_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id", "task_id"], name: "index_cards_on_board_id_and_task_id", unique: true
    t.index ["board_id"], name: "index_cards_on_board_id"
    t.index ["lane_id", "position"], name: "index_cards_on_lane_id_and_position", unique: true, where: "(archived_at IS NULL)"
    t.index ["lane_id", "task_id"], name: "index_cards_on_lane_id_and_task_id", unique: true
    t.index ["lane_id"], name: "index_cards_on_lane_id"
    t.index ["task_id"], name: "index_cards_on_task_id"
  end

  create_table "invites", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "account_id", null: false
    t.uuid "inviter_id", null: false
    t.citext "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token", null: false
    t.uuid "board_id"
    t.uuid "task_id"
    t.index ["account_id"], name: "index_invites_on_account_id"
    t.index ["email", "board_id", "task_id"], name: "index_invites_on_email_and_board_id_and_task_id", unique: true
    t.index ["inviter_id"], name: "index_invites_on_inviter_id"
    t.index ["token"], name: "index_invites_on_token", unique: true
  end

  create_table "lanes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "board_id", null: false
    t.string "title", null: false
    t.integer "stage", default: 0, null: false
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "metadata", default: {}, null: false
    t.datetime "archived_at"
    t.index ["board_id", "position"], name: "index_lanes_on_board_id_and_position", unique: true
    t.index ["board_id", "title"], name: "index_lanes_on_board_id_and_title", unique: true
    t.index ["board_id"], name: "index_lanes_on_board_id"
    t.index ["metadata"], name: "index_lanes_on_metadata", using: :gin
  end

  create_table "task_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "task_id", null: false
    t.uuid "user_id", null: false
    t.string "file", null: false
    t.integer "file_size", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "original_filename", null: false
    t.string "content_type", null: false
    t.index ["task_id"], name: "index_task_attachments_on_task_id"
    t.index ["user_id"], name: "index_task_attachments_on_user_id"
  end

  create_table "task_comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "task_id", null: false
    t.uuid "author_id", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_robot", default: false, null: false
    t.jsonb "metadata", default: {}, null: false
    t.index ["author_id"], name: "index_task_comments_on_author_id"
    t.index ["task_id", "created_at"], name: "index_task_comments_on_task_id_and_created_at"
    t.index ["task_id"], name: "index_task_comments_on_task_id"
  end

  create_table "task_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "task_id", null: false
    t.uuid "user_id", null: false
    t.datetime "seen_at", null: false
    t.index ["task_id", "user_id"], name: "index_task_users_on_task_id_and_user_id", unique: true
    t.index ["task_id"], name: "index_task_users_on_task_id"
    t.index ["user_id"], name: "index_task_users_on_user_id"
  end

  create_table "tasks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "author_id", null: false
    t.string "title", null: false
    t.text "details"
    t.datetime "completed_at"
    t.date "deadline_date"
    t.date "deadline_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "metadata", default: {}, null: false
    t.datetime "archived_at"
    t.uuid "account_id", null: false
    t.integer "comments_count", default: 0, null: false
    t.integer "attachments_count", default: 0, null: false
    t.integer "number", null: false
    t.index ["account_id", "number"], name: "index_tasks_on_account_id_and_number", unique: true
    t.index ["author_id"], name: "index_tasks_on_author_id"
    t.index ["metadata"], name: "index_tasks_on_metadata", using: :gin
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.citext "email", null: false
    t.string "access_key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.integer "failed_logins_count", default: 0
    t.datetime "lock_expires_at"
    t.string "unlock_token"
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string "locale"
    t.boolean "is_super_admin", default: false, null: false
    t.citext "nickname"
    t.index ["access_key"], name: "index_users_on_access_key", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["unlock_token"], name: "index_users_on_unlock_token"
  end

  add_foreign_key "account_memberships", "accounts"
  add_foreign_key "account_memberships", "users", column: "member_id"
  add_foreign_key "accounts", "users", column: "owner_id"
  add_foreign_key "board_memberships", "boards"
  add_foreign_key "board_memberships", "users", column: "member_id"
  add_foreign_key "boards", "accounts"
  add_foreign_key "card_memberships", "account_memberships"
  add_foreign_key "card_memberships", "cards"
  add_foreign_key "cards", "boards"
  add_foreign_key "cards", "lanes"
  add_foreign_key "cards", "tasks"
  add_foreign_key "invites", "accounts"
  add_foreign_key "invites", "boards"
  add_foreign_key "invites", "tasks"
  add_foreign_key "invites", "users", column: "inviter_id"
  add_foreign_key "lanes", "boards"
  add_foreign_key "task_attachments", "tasks"
  add_foreign_key "task_attachments", "users"
  add_foreign_key "task_comments", "tasks"
  add_foreign_key "task_comments", "users", column: "author_id"
  add_foreign_key "task_users", "tasks"
  add_foreign_key "task_users", "users"
  add_foreign_key "tasks", "accounts"
  add_foreign_key "tasks", "users", column: "author_id"
end
