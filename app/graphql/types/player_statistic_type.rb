module Types
  class PlayerStatisticType < Types::BaseObject
    description "An NFL player's statistics"
    field :id,                        ID, null: false
    field :player_id,                 ID, null: false
    field :player,                    Types::PlayerType, null: true
    field :rushing_attempts_per_game, Float,null: true
    field :rushing_attempts,          Int, null: true
    field :total_rushing_yards,       Int, null: true
    field :rushing_yards_per_attempt, Float, null: true
    field :rushing_yards_per_game,    Float, null: true
    field :total_rushing_touchdowns,  Int, null: true
    field :longest_rush,              String, null: true
    field :rushing_first_downs,       Int, null: true
    field :rushing_first_down_pct,    Float, null: true
    field :rushing_20_plus,           Int, null: true
    field :rushing_40_plus,           Int, null: true
    field :rushing_fumbles,           Int, null: true
  end
end