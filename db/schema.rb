# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_11_27_120000) do
  create_table "activities", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "activity_memberships", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.integer "activity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["activity_id"], name: "index_activity_memberships_on_activity_id"
    t.index ["user_id"], name: "index_activity_memberships_on_user_id"
  end

  create_table "flipper_features", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "key", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "feature_key", null: false
    t.string "key", null: false
    t.datetime "updated_at", null: false
    t.string "value"
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "group_memberships", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "group_id", null: false
    t.boolean "steward", default: false, null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["group_id"], name: "index_group_memberships_on_group_id"
    t.index ["user_id"], name: "index_group_memberships_on_user_id"
  end

  create_table "groups", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.integer "activity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_groups_on_activity_id"
  end

  create_table "lists", id: { type: :string, limit: 36, default: -> { "uuid()" } }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.boolean "template", default: false, null: false
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "messages", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.boolean "acknowledged", default: false, null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.integer "messageable_id", null: false
    t.string "messageable_type", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["messageable_type", "messageable_id"], name: "index_messages_on_messageable"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "sections", id: { type: :string, limit: 36, default: -> { "uuid()" } }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "default", default: false, null: false
    t.string "list_id", limit: 36, null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_sections_on_list_id"
  end

  create_table "tasks", id: { type: :string, limit: 36, default: -> { "uuid()" } }, force: :cascade do |t|
    t.boolean "completed", default: false, null: false
    t.datetime "created_at", null: false
    t.string "description"
    t.string "section_id", limit: 36, null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_tasks_on_section_id"
  end

  create_table "teams", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "timestamps", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.string "activity"
    t.datetime "created_at", null: false
    t.integer "event"
    t.string "name"
    t.datetime "timestamp"
    t.datetime "updated_at", null: false
  end

  create_table "users", id: { type: :string, limit: 36 }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "team_id", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  add_foreign_key "activity_memberships", "activities"
  add_foreign_key "activity_memberships", "activities"
  add_foreign_key "activity_memberships", "users"
  add_foreign_key "activity_memberships", "users"
  add_foreign_key "group_memberships", "groups"
  add_foreign_key "group_memberships", "groups"
  add_foreign_key "group_memberships", "users"
  add_foreign_key "group_memberships", "users"
  add_foreign_key "groups", "activities"
  add_foreign_key "groups", "activities"
  add_foreign_key "messages", "users"
  add_foreign_key "messages", "users"
  add_foreign_key "sections", "lists"
  add_foreign_key "sections", "lists"
  add_foreign_key "tasks", "sections"
  add_foreign_key "tasks", "sections"
  add_foreign_key "users", "teams"
  add_foreign_key "users", "teams"
end
