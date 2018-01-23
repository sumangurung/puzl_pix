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

ActiveRecord::Schema.define(version: 20180121014151) do

  create_table "api_keys", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "challengees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "user_uuid",                      null: false
    t.string   "unique_path_id",                 null: false
    t.boolean  "rewarded",       default: false, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["unique_path_id"], name: "index_challengees_on_unique_path_id", using: :btree
    t.index ["user_uuid", "unique_path_id"], name: "index_challengees_on_user_uuid_and_unique_path_id", unique: true, using: :btree
    t.index ["user_uuid"], name: "index_challengees_on_user_uuid", using: :btree
  end

  create_table "challenges", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "date",                                null: false
    t.integer  "user_id",                             null: false
    t.integer  "score_id",                            null: false
    t.string   "user_uuid",                           null: false
    t.string   "score_uuid",                          null: false
    t.text     "sequence",              limit: 65535, null: false
    t.string   "missing_square_number",               null: false
    t.string   "unique_path_id",                      null: false
    t.string   "picture_name",                        null: false
    t.string   "picture_url",                         null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["score_id"], name: "index_challenges_on_score_id", using: :btree
    t.index ["score_uuid"], name: "index_challenges_on_score_uuid", using: :btree
    t.index ["unique_path_id"], name: "index_challenges_on_unique_path_id", using: :btree
    t.index ["user_id"], name: "index_challenges_on_user_id", using: :btree
    t.index ["user_uuid"], name: "index_challenges_on_user_uuid", using: :btree
  end

  create_table "device_tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "token"
    t.string   "fb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "outcomes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "challengee_id", null: false
    t.integer  "score_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["challengee_id", "score_id"], name: "index_outcomes_on_challengee_id_and_score_id", unique: true, using: :btree
    t.index ["challengee_id"], name: "index_outcomes_on_challengee_id", using: :btree
    t.index ["score_id"], name: "index_outcomes_on_score_id", using: :btree
  end

  create_table "s", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "fb_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "uuid",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "date"
    t.integer  "cols",       null: false
    t.integer  "rows",       null: false
    t.integer  "game_level", null: false
    t.integer  "game_mode",  null: false
    t.integer  "moves",      null: false
    t.integer  "time",       null: false
    t.string   "user_uuid",  null: false
    t.string   "uuid",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_level"], name: "index_scores_on_game_level", using: :btree
    t.index ["game_mode"], name: "index_scores_on_game_mode", using: :btree
    t.index ["user_uuid"], name: "index_scores_on_user_uuid", using: :btree
    t.index ["uuid"], name: "index_scores_on_uuid", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username",   null: false
    t.string   "uuid",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
    t.index ["uuid"], name: "index_users_on_uuid", unique: true, using: :btree
  end

end
