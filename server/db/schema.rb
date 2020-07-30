# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_02_224808) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "diary_entries", force: :cascade do |t|
    t.bigint "stay_id", null: false
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stay_id"], name: "index_diary_entries_on_stay_id"
  end

  create_table "doctor_appointments", force: :cascade do |t|
    t.bigint "stay_id", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stay_id"], name: "index_doctor_appointments_on_stay_id"
  end

  create_table "group_activities", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.integer "repeat_every", comment: "duration (start to start) (ms) after which activity is repeated"
    t.datetime "repeat_until", comment: "activity will not be repeated past this moment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "milestone_types", force: :cascade do |t|
    t.string "name"
    t.boolean "major", default: false, null: false
    t.bigint "previous_milestone_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["previous_milestone_type_id"], name: "index_milestone_types_on_previous_milestone_type_id"
  end

  create_table "milestones", force: :cascade do |t|
    t.bigint "milestone_type_id", null: false
    t.bigint "stay_id", null: false
    t.boolean "negate", default: false, null: false
    t.text "reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["milestone_type_id"], name: "index_milestones_on_milestone_type_id"
    t.index ["stay_id"], name: "index_milestones_on_stay_id"
  end

  create_table "responsibilities", force: :cascade do |t|
    t.bigint "responsibility_type_id", null: false
    t.bigint "stay_id", null: false
    t.datetime "start_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["responsibility_type_id"], name: "index_responsibilities_on_responsibility_type_id"
    t.index ["stay_id"], name: "index_responsibilities_on_stay_id"
  end

  create_table "responsibility_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sport_bans", force: :cascade do |t|
    t.bigint "stay_id", null: false
    t.boolean "negate", default: false, null: false
    t.text "reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stay_id"], name: "index_sport_bans_on_stay_id"
  end

  create_table "stays", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.date "start_at", null: false
    t.date "end_at"
    t.bigint "godparent_id"
    t.integer "room_nr", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["godparent_id"], name: "index_stays_on_godparent_id"
    t.index ["patient_id"], name: "index_stays_on_patient_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "full_name"
    t.string "display_name"
    t.date "birthday"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "violations", force: :cascade do |t|
    t.bigint "stay_id", null: false
    t.text "reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stay_id"], name: "index_violations_on_stay_id"
  end

  add_foreign_key "diary_entries", "stays"
  add_foreign_key "doctor_appointments", "stays"
  add_foreign_key "milestone_types", "milestone_types", column: "previous_milestone_type_id"
  add_foreign_key "milestones", "milestone_types"
  add_foreign_key "milestones", "stays"
  add_foreign_key "responsibilities", "responsibility_types"
  add_foreign_key "responsibilities", "stays"
  add_foreign_key "sport_bans", "stays"
  add_foreign_key "stays", "users", column: "godparent_id"
  add_foreign_key "stays", "users", column: "patient_id"
  add_foreign_key "violations", "stays"
end
