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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120219212745) do

  create_table "patrons", :force => true do |t|
    t.integer   "foursquare_id"
    t.string    "f_name"
    t.string    "l_name"
    t.string    "gender"
    t.string    "photo"
    t.string    "home_city"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "patrons", ["foursquare_id"], :name => "index_patrons_on_foursquare_id"

  create_table "tags", :force => true do |t|
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venues", :force => true do |t|
    t.string   "foursquare_id"
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "daily_trend_count"
    t.datetime "daily_trend_time"
    t.integer  "weekly_trend_count"
    t.datetime "weekly_trend_time"
    t.integer  "monthly_trend_count"
    t.datetime "monthly_trend_time"
    t.integer  "yearly_trend_count"
    t.datetime "yearly_trend_time"
    t.integer  "frat_score"
    t.integer  "sport_score"
    t.integer  "hipster_score"
    t.integer  "dive_score"
    t.integer  "exclusive_score"
    t.integer  "dance_score"
  end

  add_index "venues", ["foursquare_id"], :name => "index_venues_on_foursquare_id"

  create_table "visits", :force => true do |t|
    t.integer   "patron_id"
    t.integer   "venue_id"
    t.integer   "fs_created_at"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "visits", ["patron_id"], :name => "index_visits_on_patron_id"
  add_index "visits", ["venue_id"], :name => "index_visits_on_venue_id"

end
