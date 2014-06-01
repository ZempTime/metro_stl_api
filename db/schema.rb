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

ActiveRecord::Schema.define(version: 0) do

  create_table "calendar_dates", id: false, force: true do |t|
    t.string  "service_id"
    t.integer "date"
    t.integer "exception_type"
  end

  create_table "calendars", id: false, force: true do |t|
    t.string  "service_id"
    t.integer "start_date"
    t.integer "end_date"
    t.boolean "monday"
    t.boolean "tuesday"
    t.boolean "wednesday"
    t.boolean "thursday"
    t.boolean "friday"
    t.boolean "saturday"
    t.boolean "sunday"
  end

  create_table "routes", force: true do |t|
    t.integer "route_id"
    t.string  "route_long_name"
    t.integer "route_type"
    t.string  "agency_id"
    t.string  "route_color"
    t.string  "route_short_name"
  end

  create_table "stop_times", force: true do |t|
    t.integer "trip_id"
    t.text    "arrival_time"
    t.text    "departure_time"
    t.integer "stop_id"
    t.integer "stop_sequence"
    t.string  "stop_headsign"
    t.string  "pickup_type"
    t.string  "drop_off_type"
    t.string  "shape_dist_traveled"
    t.decimal "time_difference",     precision: 11, scale: 0
  end

  create_table "stops", force: true do |t|
    t.integer "stop_id"
    t.string  "stop_lat"
    t.string  "zone_id"
    t.string  "stop_lon"
    t.string  "stop_desc"
    t.string  "stop_name"
    t.integer "location_type"
  end

  create_table "trips", force: true do |t|
    t.integer "trip_id"
    t.string  "block_id"
    t.integer "route_id"
    t.integer "direction_id"
    t.string  "trip_headsign"
    t.integer "shape_id"
    t.string  "service_id"
  end

end

