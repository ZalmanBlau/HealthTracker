# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151109034455) do

  create_table "appointments", force: :cascade do |t|
    t.string   "doctor"
    t.string   "location"
    t.datetime "date"
    t.text     "reasons"
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "cal_date"
    t.string   "appt_type",  default: "standard", null: false
    t.time     "time"
  end

  create_table "checkups_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "yearly_checkup_id"
  end

  add_index "checkups_users", ["user_id"], name: "index_checkups_users_on_user_id"
  add_index "checkups_users", ["yearly_checkup_id"], name: "index_checkups_users_on_yearly_checkup_id"

  create_table "circles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "food_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "usda_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foods", force: :cascade do |t|
    t.string   "name"
    t.integer  "calories"
    t.integer  "usda_id"
    t.integer  "food_group_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "illness_symptoms", force: :cascade do |t|
    t.integer  "illness_id"
    t.integer  "symptom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "illnesses", force: :cascade do |t|
    t.string   "common_term"
    t.string   "medical_term"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "medications", force: :cascade do |t|
    t.string   "brand_name"
    t.string   "generic_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id"
    t.integer "prescription_id"
    t.string  "message"
    t.string  "date"
  end

  add_index "notifications", ["prescription_id"], name: "index_notifications_on_prescription_id"
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "pending_events", force: :cascade do |t|
    t.integer "user_id"
    t.string  "appt_type"
  end

  add_index "pending_events", ["user_id"], name: "index_pending_events_on_user_id"

  create_table "prescriptions", force: :cascade do |t|
    t.integer "user_id"
    t.string  "name"
    t.integer "amount"
    t.integer "refills"
    t.integer "dosage"
    t.integer "frequency"
    t.integer "remainder"
    t.time    "first_dose"
    t.integer "used_refills"
  end

  create_table "symptoms", force: :cascade do |t|
    t.string   "common_term"
    t.string   "medical_term"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.string   "status",     default: "pending"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "user_circles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "circle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_illnesses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "illness_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "severity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_medications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "medication_id"
    t.integer  "amount"
    t.integer  "frequency"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "user_sleeps", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "hours"
    t.time     "start"
    t.time     "wake"
    t.string   "quality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_sleeps", ["user_id"], name: "index_user_sleeps_on_user_id"

  create_table "user_stats", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "feeling"
    t.integer  "sleep"
    t.integer  "calories"
    t.integer  "exercise"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_statuses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_statuses", ["user_id"], name: "index_user_statuses_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthdate"
    t.integer  "height"
    t.integer  "weight"
    t.string   "gender"
    t.integer  "zipcode"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "phonenumber"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "yearly_checkups", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.date   "checkup_date"
  end

end
