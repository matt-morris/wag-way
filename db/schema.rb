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

ActiveRecord::Schema[7.0].define(version: 2023_09_15_034542) do
  create_table "addresses", force: :cascade do |t|
    t.string "street_address", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "postal_code", null: false
    t.string "country_code", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["latitude", "longitude"], name: "index_addresses_on_latitude_and_longitude"
  end

  create_table "availabilities", force: :cascade do |t|
    t.integer "walker_id", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["walker_id"], name: "index_availabilities_on_walker_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "email", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_owners_on_email", unique: true
    t.index ["latitude", "longitude"], name: "index_owners_on_latitude_and_longitude"
  end

  create_table "walkers", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "avatar_url", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.integer "radius", default: 10, null: false
    t.integer "hourly_rate_in_cents", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_walkers_on_email", unique: true
    t.index ["latitude", "longitude"], name: "index_walkers_on_latitude_and_longitude"
  end

  create_table "walks", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.integer "owner_id", null: false
    t.integer "walker_id", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.integer "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_walks_on_address_id"
    t.index ["latitude", "longitude"], name: "index_walks_on_latitude_and_longitude"
    t.index ["owner_id"], name: "index_walks_on_owner_id"
    t.index ["status"], name: "index_walks_on_status"
    t.index ["walker_id"], name: "index_walks_on_walker_id"
  end

  add_foreign_key "availabilities", "walkers"
  add_foreign_key "walks", "addresses"
  add_foreign_key "walks", "owners"
  add_foreign_key "walks", "walkers"
end
