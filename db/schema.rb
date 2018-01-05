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

ActiveRecord::Schema.define(version: 20180105063306) do

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.integer "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_cities_on_region_id"
  end

  create_table "city_interests", force: :cascade do |t|
    t.integer "profile_id"
    t.integer "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_city_interests_on_city_id"
    t.index ["profile_id"], name: "index_city_interests_on_profile_id"
  end

  create_table "event_interests", force: :cascade do |t|
    t.integer "profile_id"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_interests_on_event_id"
    t.index ["profile_id"], name: "index_event_interests_on_profile_id"
  end

  create_table "events", force: :cascade do |t|
    t.date "date"
    t.string "title"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "url"
    t.string "subtitle"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string "admission"
    t.text "extras"
    t.datetime "doors"
    t.index ["location_id"], name: "index_events_on_location_id"
  end

  create_table "location_interests", force: :cascade do |t|
    t.integer "profile_id"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_location_interests_on_location_id"
    t.index ["profile_id"], name: "index_location_interests_on_profile_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "events_url"
    t.string "street"
    t.string "zip"
    t.integer "region_id"
    t.integer "city_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "region_interests", force: :cascade do |t|
    t.integer "profile_id"
    t.integer "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_region_interests_on_profile_id"
    t.index ["region_id"], name: "index_region_interests_on_region_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

end
