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

ActiveRecord::Schema[8.1].define(version: 2023_11_06_103321) do
  create_table "lists", id: { type: :string, limit: 36, default: -> { "uuid()" } }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.boolean "template", default: false, null: false
    t.string "title"
    t.datetime "updated_at", null: false
  end

# Could not dump table "sections" because of following StandardError
#   Unknown type 'uuid' for column 'id'


  create_table "tasks", id: { type: :string, limit: 36, default: -> { "uuid()" } }, force: :cascade do |t|
    t.boolean "completed", default: false, null: false
    t.datetime "created_at", null: false
    t.string "description"
    t.string "section_id", limit: 36, null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_tasks_on_section_id"
  end

  add_foreign_key "sections", "lists"
  add_foreign_key "tasks", "sections"
end
