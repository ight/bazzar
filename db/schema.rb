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

ActiveRecord::Schema.define(version: 20171130103047) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string   "name",        default: "Bazzar", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "category_id"
    t.index ["category_id"], name: "index_brands_on_category_id", using: :btree
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.boolean  "processed",  default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["item_id"], name: "index_cart_items_on_item_id", using: :btree
    t.index ["user_id"], name: "index_cart_items_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "category_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "price",       null: false
    t.string   "code",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "brand_id"
    t.integer  "category_id"
    t.index ["brand_id"], name: "index_items_on_brand_id", using: :btree
    t.index ["category_id"], name: "index_items_on_category_id", using: :btree
    t.index ["code"], name: "index_items_on_code", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",     null: false
    t.string   "last_name",      null: false
    t.string   "contact_number", null: false
    t.string   "email",          null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["contact_number"], name: "index_users_on_contact_number", using: :btree
    t.index ["email"], name: "index_users_on_email", using: :btree
  end

end
