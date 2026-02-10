# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2026_01_25_111708) do
  create_table "charges", force: :cascade do |t|
    t.date "charge_date"
    t.decimal "amount"
    t.text "notes"
    t.integer "quote_id", null: false
    t.integer "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_charges_on_member_id"
    t.index ["quote_id"], name: "index_charges_on_quote_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "address"
    t.date "birth_date"
    t.date "churn_date"
    t.string "city"
    t.string "zip_code"
    t.string "phone"
    t.string "document_number"
    t.string "first_name"
    t.string "surnames"
    t.date "join_date"
    t.string "province"
    t.string "user_name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.integer "number"
  end

  create_table "quotes", force: :cascade do |t|
    t.string "description"
    t.decimal "amount"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "charges", "members"
  add_foreign_key "charges", "quotes"
end
