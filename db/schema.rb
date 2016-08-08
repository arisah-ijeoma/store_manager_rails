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

ActiveRecord::Schema.define(version: 20160509095807) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "",        null: false
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "role",                   default: "regular"
    t.string   "first_name",             default: "",        null: false
    t.string   "last_name",              default: "",        null: false
    t.string   "establishment",          default: "",        null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "category",                   null: false
    t.string   "name",                       null: false
    t.integer  "quantity",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "min_qty",                    null: false
    t.integer  "quantity_sold", default: 0,  null: false
    t.integer  "new_stock",     default: 0,  null: false
    t.integer  "admin_user_id"
    t.string   "brand",         default: "", null: false
    t.integer  "initial_qty",   default: 0,  null: false
    t.integer  "sold_qty",      default: 0,  null: false
    t.integer  "added_qty",     default: 0,  null: false
  end

  add_index "items", ["admin_user_id"], name: "index_items_on_admin_user_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "phone_number"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.integer  "admin_user_id"
    t.string   "salutation"
    t.string   "mobile_number"
  end

  add_index "profiles", ["admin_user_id"], name: "index_profiles_on_admin_user_id", using: :btree
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.integer  "admin_user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "quantity_sold", default: 0, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.integer  "admin_user_id"
    t.string   "nick"
  end

  add_index "users", ["admin_user_id"], name: "index_users_on_admin_user_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "items", "admin_users"
  add_foreign_key "profiles", "admin_users"
  add_foreign_key "profiles", "users"
end
