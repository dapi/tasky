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

ActiveRecord::Schema.define(version: 2019_06_05_091515) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_memberships", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "member_id"], name: "index_account_memberships_on_account_id_and_member_id", unique: true
    t.index ["account_id"], name: "index_account_memberships_on_account_id"
    t.index ["member_id"], name: "index_account_memberships_on_member_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.bigint "owner_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_accounts_on_owner_id"
  end

  create_table "boards", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_boards_on_account_id"
  end

  create_table "invites", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "inviter_id", null: false
    t.string "email", null: false
    t.bigint "invitee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_invites_on_account_id"
    t.index ["email"], name: "index_invites_on_email", unique: true
    t.index ["invitee_id"], name: "index_invites_on_invitee_id"
    t.index ["inviter_id"], name: "index_invites_on_inviter_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
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
    t.index ["access_key"], name: "index_users_on_access_key", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["unlock_token"], name: "index_users_on_unlock_token"
  end

  add_foreign_key "account_memberships", "accounts"
  add_foreign_key "account_memberships", "users", column: "member_id"
  add_foreign_key "accounts", "users", column: "owner_id"
  add_foreign_key "boards", "accounts"
  add_foreign_key "invites", "accounts"
  add_foreign_key "invites", "users", column: "invitee_id"
  add_foreign_key "invites", "users", column: "inviter_id"
end
