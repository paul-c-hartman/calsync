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

ActiveRecord::Schema[8.1].define(version: 2026_04_16_210759) do
  create_table "calendars", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "feed_url"
    t.string "label"
    t.datetime "last_synced_at"
    t.string "provider_id"
    t.string "sync_cursor"
    t.datetime "updated_at", null: false
    t.integer "user_account_id", null: false
    t.index ["user_account_id"], name: "index_calendars_on_user_account_id"
  end

  create_table "events", force: :cascade do |t|
    t.boolean "all_day", default: false
    t.boolean "busy", default: true
    t.integer "calendar_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.datetime "ends_at", null: false
    t.string "provider_id", null: false
    t.datetime "starts_at", null: false
    t.string "time_zone", default: "UTC"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["calendar_id", "provider_id"], name: "index_events_on_calendar_id_and_provider_id", unique: true
    t.index ["calendar_id", "starts_at"], name: "index_events_on_calendar_id_and_starts_at", unique: true
    t.index ["calendar_id"], name: "index_events_on_calendar_id"
    t.check_constraint "starts_at < ends_at", name: "check_starts_at_before_ends_at"
  end

  create_table "flow_filters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "field_name", null: false
    t.integer "flow_id", null: false
    t.integer "operator", null: false
    t.datetime "updated_at", null: false
    t.json "value_json"
    t.index ["flow_id"], name: "index_flow_filters_on_flow_id"
  end

  create_table "flow_transforms", force: :cascade do |t|
    t.integer "action", default: 0, null: false
    t.datetime "created_at", null: false
    t.string "field_name", null: false
    t.integer "flow_id", null: false
    t.integer "position", null: false
    t.datetime "updated_at", null: false
    t.json "value_json"
    t.index ["flow_id", "position"], name: "index_flow_transforms_on_flow_id_and_position", unique: true
    t.index ["flow_id"], name: "index_flow_transforms_on_flow_id"
  end

  create_table "flows", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "destination_calendar_id", null: false
    t.string "label"
    t.integer "source_calendar_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["destination_calendar_id"], name: "index_flows_on_destination_calendar_id"
    t.index ["source_calendar_id", "destination_calendar_id"], name: "index_flows_on_source_calendar_id_and_destination_calendar_id", unique: true
    t.index ["source_calendar_id"], name: "index_flows_on_source_calendar_id"
    t.index ["user_id"], name: "index_flows_on_user_id"
    t.check_constraint "source_calendar_id <> destination_calendar_id", name: "flows_source_destination_different"
  end

  create_table "user_accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "provider", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_user_accounts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "display_name", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "calendars", "user_accounts"
  add_foreign_key "events", "calendars"
  add_foreign_key "flow_filters", "flows"
  add_foreign_key "flow_transforms", "flows"
  add_foreign_key "flows", "calendars", column: "destination_calendar_id"
  add_foreign_key "flows", "calendars", column: "source_calendar_id"
  add_foreign_key "flows", "users"
  add_foreign_key "user_accounts", "users"
end
