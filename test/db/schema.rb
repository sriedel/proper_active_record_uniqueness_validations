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

ActiveRecord::Schema.define(version: 20130608160945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "things", force: true do |t|
    t.integer  "some_id"
    t.text     "name"
    t.text     "description"
    t.text     "unregistered"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "things", ["name", "description"], name: "index_things_on_name_and_description", unique: true, using: :btree
  add_index "things", ["some_id"], name: "index_things_on_some_id", unique: true, using: :btree
  add_index "things", ["unregistered"], name: "index_things_on_unregistered", unique: true, using: :btree

  create_table "widgets", force: true do |t|
    t.integer  "some_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
