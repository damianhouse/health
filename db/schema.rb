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

ActiveRecord::Schema.define(version: 20160718134322) do

  create_table "coaches", force: :cascade do |t|
    t.string   "first"
    t.string   "email"
    t.string   "password_digest"
    t.string   "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "avatar_url"
    t.string   "phone"
    t.string   "zip"
    t.string   "last"
    t.text     "greeting"
    t.text     "philosophy"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "coach_id"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.boolean  "read"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "coach_id"
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "coach_id"
    t.string   "note_1"
    t.string   "note_2"
    t.string   "note_3"
    t.string   "note_4"
    t.string   "note_5"
    t.string   "note_6"
    t.string   "note_7"
    t.string   "note_8"
    t.string   "note_9"
    t.string   "note_10"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first"
    t.string   "email"
    t.string   "password_digest"
    t.string   "role"
    t.integer  "coach_id"
    t.integer  "coach_1"
    t.integer  "coach_2"
    t.integer  "coach_3"
    t.integer  "coach_4"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "avatar_url"
    t.string   "phone"
    t.string   "zip"
    t.string   "last_name"
    t.string   "last"
    t.boolean  "paid"
    t.boolean  "admin"
  end

end
