# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_03_09_143722) do

  create_table "appliances", force: :cascade do |t|
    t.string "category"
    t.string "appliance_type"
    t.string "make"
    t.string "model"
    t.integer "year"
    t.date "last_serviced"
    t.date "service_due"
    t.text "notes"
    t.integer "house_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "contact_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "company_name"
    t.string "contact_name"
    t.string "contact_type"
    t.string "email"
    t.string "phone_number"
    t.integer "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "houses", force: :cascade do |t|
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.date "purchase_date"
    t.integer "owner_id"
    t.string "primary_residence"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "maintenance_events", force: :cascade do |t|
    t.text "description"
    t.date "maintenance_date"
    t.integer "house_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "projects", force: :cascade do |t|
    t.text "description"
    t.string "status"
    t.date "date_started"
    t.date "date_completed"
    t.text "notes"
    t.integer "house_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "contact_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
