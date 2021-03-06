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

ActiveRecord::Schema.define(version: 20150930010439) do

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.integer  "location_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.datetime "arrival"
    t.datetime "departure"
    t.integer  "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "locations", ["trip_id"], name: "index_locations_on_trip_id"

  create_table "trips", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "start_loc"
    t.string   "end_loc"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "trips", ["user_id", "created_at"], name: "index_trips_on_user_id_and_created_at"
  add_index "trips", ["user_id"], name: "index_trips_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
