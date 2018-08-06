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

ActiveRecord::Schema.define(version: 2018_08_06_153429) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "payment_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "payment_method", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.float "unit_price"
    t.boolean "tax_exempted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receipts", force: :cascade do |t|
    t.json "details", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.float "total_amount", null: false
    t.string "status"
    t.string "payment_gateway"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "payment_type_id"
    t.bigint "receipt_id"
    t.index ["payment_gateway"], name: "index_transactions_on_payment_gateway"
    t.index ["payment_type_id"], name: "index_transactions_on_payment_type_id"
    t.index ["receipt_id"], name: "index_transactions_on_receipt_id"
    t.index ["status"], name: "index_transactions_on_status"
  end

  add_foreign_key "transactions", "payment_types"
  add_foreign_key "transactions", "receipts"
end
