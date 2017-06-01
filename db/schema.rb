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

ActiveRecord::Schema.define(version: 20170528042253) do

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "profile_img"
    t.string   "background_img"
    t.string   "invite_code"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "privated"
  end

  create_table "marks", force: :cascade do |t|
    t.integer  "groups_id"
    t.integer  "timetable_id"
    t.integer  "user_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "white_list"
    t.string   "title"
    t.text     "content"
    t.string   "url"
    t.string   "image"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["groups_id"], name: "index_marks_on_groups_id"
    t.index ["timetable_id"], name: "index_marks_on_timetable_id"
    t.index ["user_id"], name: "index_marks_on_user_id"
  end

  create_table "timetables", force: :cascade do |t|
    t.integer  "group_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "start_day_time"
    t.datetime "end_day_time"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["group_id"], name: "index_timetables_on_group_id"
  end

  create_table "userlists", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_userlists_on_group_id"
    t.index ["user_id"], name: "index_userlists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",          null: false
    t.string   "encrypted_password",     default: "",          null: false
    t.boolean  "admin",                  default: false,       null: false
    t.boolean  "active",                 default: true,        null: false
    t.integer  "role",                   default: 1,           null: false
    t.integer  "point",                  default: 0,           null: false
    t.string   "nickname",               default: "Anonymous", null: false
    t.datetime "birthday"
    t.string   "name"
    t.string   "image"
    t.string   "img"
    t.string   "provider"
    t.string   "uid"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,           null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
