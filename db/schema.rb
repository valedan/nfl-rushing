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

ActiveRecord::Schema.define(version: 2020_03_06_205904) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "player_statistics", force: :cascade do |t|
    t.bigint "player_id"
    t.float "rushing_attempts_per_game"
    t.integer "rushing_attempts"
    t.integer "total_rushing_yards"
    t.float "rushing_yards_per_attempt"
    t.float "rushing_yards_per_game"
    t.integer "total_rushing_touchdowns"
    t.string "longest_rush"
    t.integer "rushing_first_downs"
    t.float "rushing_first_down_pct"
    t.integer "rushing_20_plus"
    t.integer "rushing_40_plus"
    t.integer "rushing_fumbles"
    t.index ["longest_rush"], name: "index_player_statistics_on_longest_rush"
    t.index ["player_id"], name: "index_player_statistics_on_player_id"
    t.index ["rushing_20_plus"], name: "index_player_statistics_on_rushing_20_plus"
    t.index ["rushing_40_plus"], name: "index_player_statistics_on_rushing_40_plus"
    t.index ["rushing_attempts"], name: "index_player_statistics_on_rushing_attempts"
    t.index ["rushing_attempts_per_game"], name: "index_player_statistics_on_rushing_attempts_per_game"
    t.index ["rushing_first_down_pct"], name: "index_player_statistics_on_rushing_first_down_pct"
    t.index ["rushing_first_downs"], name: "index_player_statistics_on_rushing_first_downs"
    t.index ["rushing_fumbles"], name: "index_player_statistics_on_rushing_fumbles"
    t.index ["rushing_yards_per_attempt"], name: "index_player_statistics_on_rushing_yards_per_attempt"
    t.index ["rushing_yards_per_game"], name: "index_player_statistics_on_rushing_yards_per_game"
    t.index ["total_rushing_touchdowns"], name: "index_player_statistics_on_total_rushing_touchdowns"
    t.index ["total_rushing_yards"], name: "index_player_statistics_on_total_rushing_yards"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "team"
    t.string "position"
    t.index ["name"], name: "index_players_on_name"
  end

end
