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

ActiveRecord::Schema.define(version: 20150222230734) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challengees", force: :cascade do |t|
    t.string   "fb_id"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenges", force: :cascade do |t|
    t.date     "date"
    t.string   "picture_url"
    t.string   "thumb_url"
    t.string   "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "device_tokens", force: :cascade do |t|
    t.string   "token"
    t.string   "fb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: :cascade do |t|
    t.string   "fb_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scores", force: :cascade do |t|
    t.date     "date"
    t.integer  "player_id"
    t.string   "game_id"
    t.integer  "cols"
    t.integer  "rows"
    t.integer  "difficulty"
    t.integer  "game_mode"
    t.integer  "moves"
    t.integer  "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
