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

ActiveRecord::Schema.define(version: 20200304134240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "ar_internal_metadata", primary_key: "key", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "contract_id"
    t.string   "attachment"
    t.string   "doc_type"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buildings", force: :cascade do |t|
    t.string  "name"
    t.integer "organization_id"
    t.text    "address"
    t.string  "zipcode"
    t.string  "city"
    t.string  "country"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "acronym"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_contracts", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "contract_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories_contracts", ["category_id"], name: "index_categories_contracts_on_category_id", using: :btree
  add_index "categories_contracts", ["contract_id"], name: "index_categories_contracts_on_contract_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "tel_fix"
    t.string   "mobile"
    t.text     "address"
    t.string   "zipcode"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contracts", force: :cascade do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "provider_id"
    t.text     "comment"
    t.float    "price"
    t.integer  "currency_id"
    t.boolean  "grouped"
    t.string   "number"
    t.boolean  "registered"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "tender"
    t.boolean  "locked"
  end

  create_table "contracts_items", force: :cascade do |t|
    t.integer  "contract_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contracts_items", ["contract_id"], name: "index_contracts_items_on_contract_id", using: :btree
  add_index "contracts_items", ["item_id"], name: "index_contracts_items_on_item_id", using: :btree

  create_table "contracts_teams", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "contract_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contracts_teams", ["contract_id"], name: "index_contracts_teams_on_contract_id", using: :btree
  add_index "contracts_teams", ["team_id"], name: "index_contracts_teams_on_team_id", using: :btree

  create_table "currencies", force: :cascade do |t|
    t.string   "name"
    t.boolean  "is_default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "days", force: :cascade do |t|
    t.integer  "occurance_id"
    t.date     "date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment"
  end

  create_table "departments_users", force: :cascade do |t|
    t.integer "team_id"
    t.integer "user_id"
  end

  add_index "departments_users", ["team_id"], name: "index_departments_users_on_team_id", using: :btree
  add_index "departments_users", ["user_id"], name: "index_departments_users_on_user_id", using: :btree

  create_table "item_attachments", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "name"
    t.string   "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "barcode"
    t.string   "name"
    t.string   "serial_number"
    t.string   "owner_inventory"
    t.date     "installation_date"
    t.decimal  "price"
    t.decimal  "residue"
    t.decimal  "interval"
    t.decimal  "duration"
    t.decimal  "amortization"
    t.string   "folder"
    t.boolean  "registered"
    t.string   "order"
    t.text     "order_note"
    t.string   "invoice"
    t.text     "invoice_note"
    t.text     "comment"
    t.boolean  "deleted"
    t.date     "date_of_deletion"
    t.integer  "location_id"
    t.integer  "category_id"
    t.integer  "provider_id"
    t.integer  "brand_id"
    t.integer  "owner_id"
    t.string   "funding"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "status_id"
    t.integer  "currency_id"
    t.string   "contract_id"
    t.boolean  "donation"
    t.datetime "deleted_at"
    t.integer  "item_user_id"
    t.text     "recap"
    t.text     "recap_conf"
  end

  add_index "items", ["deleted_at"], name: "index_items_on_deleted_at", using: :btree

  create_table "items_teams", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items_teams", ["item_id"], name: "index_items_teams_on_item_id", using: :btree
  add_index "items_teams", ["team_id"], name: "index_items_teams_on_team_id", using: :btree

  create_table "items_users", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items_users", ["item_id"], name: "index_items_users_on_item_id", using: :btree
  add_index "items_users", ["user_id"], name: "index_items_users_on_user_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.integer  "building_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "occurances", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "name"
    t.text     "comment"
    t.boolean  "done"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade do |t|
    t.boolean  "display_all"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "display_all_users"
    t.boolean  "display_all_contracts"
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "acronym"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "owners", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions", force: :cascade do |t|
    t.string   "name"
    t.string   "acronym"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions_users", force: :cascade do |t|
    t.integer  "position_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "positions_users", ["position_id"], name: "index_positions_users_on_position_id", using: :btree
  add_index "positions_users", ["user_id"], name: "index_positions_users_on_user_id", using: :btree

  create_table "providers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "address"
    t.string   "email"
    t.integer  "tel"
  end

  create_table "references", force: :cascade do |t|
    t.string   "name"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "language"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["context"], name: "index_taggings_on_context", using: :btree
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "topic"
    t.integer  "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id"
    t.string   "acronym"
  end

  create_table "teams_users", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams_users", ["team_id"], name: "index_teams_users_on_team_id", using: :btree
  add_index "teams_users", ["user_id"], name: "index_teams_users_on_user_id", using: :btree

  create_table "types", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "username"
    t.string   "tel1"
    t.string   "tel2"
    t.integer  "location_id"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "item_user_id"
    t.string   "role",                   default: "guest"
    t.text     "recap"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "taggings", "tags"
end
