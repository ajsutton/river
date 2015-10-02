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

ActiveRecord::Schema.define(version: 20150929111714) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "churches", force: :cascade do |t|
    t.string   "shortname",  limit: 16
    t.string   "name"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "churches", ["shortname"], name: "index_churches_on_shortname", unique: true, using: :btree

  create_table "custom_fields", force: :cascade do |t|
    t.integer  "church_id"
    t.string   "applies_to"
    t.jsonb    "fields"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "custom_fields", ["church_id", "applies_to"], name: "index_custom_fields_on_church_id_and_applies_to", using: :btree
  add_index "custom_fields", ["church_id"], name: "index_custom_fields_on_church_id", using: :btree

  create_table "identities", force: :cascade do |t|
    t.string  "uid"
    t.string  "provider"
    t.integer "user_id"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.jsonb    "fields"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "church_id"
  end

  add_index "people", ["church_id"], name: "index_people_on_church_id", using: :btree
  add_index "people", ["fields"], name: "index_people_on_fields", using: :gin

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.integer  "church_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
  end

  add_index "users", ["church_id"], name: "index_users_on_church_id", using: :btree

  create_table "views", force: :cascade do |t|
    t.integer  "church_id",  null: false
    t.string   "applies_to", null: false
    t.string   "name",       null: false
    t.string   "fields",     null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "views", ["church_id", "applies_to", "name"], name: "index_views_on_church_id_and_applies_to_and_name", using: :btree
  add_index "views", ["church_id"], name: "index_views_on_church_id", using: :btree

  add_foreign_key "custom_fields", "churches"
  add_foreign_key "people", "churches"
  add_foreign_key "users", "churches"
  add_foreign_key "views", "churches"
end
