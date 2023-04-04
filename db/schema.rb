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

ActiveRecord::Schema[7.0].define(version: 2023_04_04_223942) do
  create_table "role_requests", force: :cascade do |t|
    t.integer "request_state"
    t.integer "requested_template_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "requester_user_id"
    t.integer "approver_user_id"
    t.string "description"
    t.string "decision_reasoning"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.integer "stratus_role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "role_requests", "users", column: "approver_user_id"
  add_foreign_key "role_requests", "users", column: "requester_user_id"
end
