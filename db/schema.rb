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

ActiveRecord::Schema.define(version: 20160815212913) do

  create_table "items", force: :cascade do |t|
    t.string   "barcode"
    t.string   "name"
    t.text     "description"
    t.integer  "current_quantity"
    t.integer  "minimum_quantity"
    t.decimal  "sale_price"
    t.text     "notes"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "items_tags", id: false, force: :cascade do |t|
    t.integer "item_id"
    t.integer "tag_id"
    t.index ["item_id"], name: "index_items_tags_on_item_id"
    t.index ["tag_id"], name: "index_items_tags_on_tag_id"
  end

  create_table "items_types", id: false, force: :cascade do |t|
    t.integer "item_id"
    t.integer "type_id"
    t.index ["item_id"], name: "index_items_types_on_item_id"
    t.index ["type_id"], name: "index_items_types_on_type_id"
  end

  create_table "print_request_actions", force: :cascade do |t|
    t.integer  "print_request_id"
    t.integer  "print_request_status_id"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["print_request_id"], name: "index_print_request_actions_on_print_request_id"
    t.index ["print_request_status_id"], name: "index_print_request_actions_on_print_request_status_id"
    t.index ["user_id"], name: "index_print_request_actions_on_user_id"
  end

  create_table "print_request_statuses", force: :cascade do |t|
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "print_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "quantity"
    t.decimal  "model_volume"
    t.decimal  "quoted_price",            precision: 8, scale: 2
    t.text     "notes"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "print_file_file_name"
    t.string   "print_file_content_type"
    t.integer  "print_file_file_size"
    t.datetime "print_file_updated_at"
    t.decimal  "support_volume"
    t.datetime "due_at"
    t.decimal  "billed_price",            precision: 8, scale: 2
    t.index ["user_id"], name: "index_print_requests_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
