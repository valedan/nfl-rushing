class CreatePlayerStatistics < ActiveRecord::Migration[6.0]
  def change
    create_table :player_statistics do |t|
      t.belongs_to :player
      t.float :rushing_attempts_per_game, index: true
      t.integer :rushing_attempts, index: true
      t.integer :total_rushing_yards, index: true
      t.float :rushing_yards_per_attempt, index: true
      t.float :rushing_yards_per_game, index: true
      t.integer :total_rushing_touchdowns, index: true
      t.integer :longest_rush_distance, index: true
      t.boolean :longest_rush_touchdown
      t.integer :rushing_first_downs, index: true
      t.float :rushing_first_down_pct, index: true
      t.integer :rushing_20_plus, index: true
      t.integer :rushing_40_plus, index: true
      t.integer :rushing_fumbles, index: true
    end
  end
end
