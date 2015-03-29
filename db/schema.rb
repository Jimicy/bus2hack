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

ActiveRecord::Schema.define(version: 20150328072104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buses", force: :cascade do |t|
    t.integer  "hackathon_id"
    t.string   "school"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "buses", ["hackathon_id"], name: "index_buses_on_hackathon_id", using: :btree

  create_table "hackathon_statuses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "bus_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hackathon_statuses", ["bus_id"], name: "index_hackathon_statuses_on_bus_id", using: :btree
  add_index "hackathon_statuses", ["user_id"], name: "index_hackathon_statuses_on_user_id", using: :btree

  create_table "hackathons", force: :cascade do |t|
    t.string   "name"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "school"
    t.datetime "passport_expiry_date"
    t.text     "confirmed_emails",     default: [], array: true
    t.text     "unconfirmed_emails",   default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
