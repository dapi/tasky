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

ActiveRecord::Schema.define(version: 2019_06_03_172247) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.bigint "lane_id", null: false
    t.bigint "author_id", null: false
    t.string "title"
    t.text "details"
    t.json "meta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_cards_on_author_id"
    t.index ["lane_id"], name: "index_cards_on_lane_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "name"], name: "index_companies_on_owner_id_and_name", unique: true
    t.index ["owner_id"], name: "index_companies_on_owner_id"
    t.index ["slug"], name: "index_companies_on_slug", unique: true
  end

  create_table "dashboards", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "company_id", null: false
    t.bigint "owner_id", null: false
    t.integer "lanes_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id", "title"], name: "index_dashboards_on_company_id_and_title", unique: true
    t.index ["company_id"], name: "index_dashboards_on_company_id"
    t.index ["owner_id"], name: "index_dashboards_on_owner_id"
  end

  create_table "lanes", force: :cascade do |t|
    t.bigint "dashboard_id", null: false
    t.string "title", null: false
    t.integer "cards_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_id"], name: "index_lanes_on_dashboard_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id", "user_id"], name: "index_memberships_on_company_id_and_user_id"
    t.index ["company_id"], name: "index_memberships_on_company_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "cards", "lanes"
  add_foreign_key "cards", "users", column: "author_id"
  add_foreign_key "companies", "users", column: "owner_id"
  add_foreign_key "dashboards", "companies"
  add_foreign_key "dashboards", "users", column: "owner_id"
  add_foreign_key "lanes", "dashboards"
  add_foreign_key "memberships", "companies"
  add_foreign_key "memberships", "users"
end
