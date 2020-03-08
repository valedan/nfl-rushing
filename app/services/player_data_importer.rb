class PlayerDataImporter < ApplicationService
  def initialize(data)
    @data = data
  end

  def call
    ActiveRecord::Base.transaction do
      @data.each do |player_stats|
        player = create_player(player_stats)
        create_stats(player, player_stats)
      end
    end
  end

  private

  def create_player(player_stats)
    # Assuming the combination of name/team/position is unique
    Player.where(
      name: player_stats["Player"],
      team: player_stats["Team"],
      position: player_stats["Pos"]
    ).first_or_create!
  end
  
  def create_stats(player, player_stats)
    # TODO: This is very verbose
    player.stats.update!(
      rushing_attempts:          player_stats["Att"]   || player.stats.rushing_attempts,
      rushing_attempts_per_game: player_stats["Att/G"] || player.stats.rushing_attempts_per_game,
      total_rushing_yards:       player_stats["Yds"]   || player.stats.total_rushing_yards,
      rushing_yards_per_attempt: player_stats["Avg"]   || player.stats.rushing_yards_per_attempt,
      rushing_yards_per_game:    player_stats["Yds/G"] || player.stats.rushing_yards_per_game,
      total_rushing_touchdowns:  player_stats["TD"]    || player.stats.total_rushing_touchdowns,
      longest_rush:              player_stats["Lng"]   || player.stats.longest_rush,
      rushing_first_downs:       player_stats["1st"]   || player.stats.rushing_first_downs,
      rushing_first_down_pct:    player_stats["1st%"]  || player.stats.rushing_first_down_pct, 
      rushing_20_plus:           player_stats["20+"]   || player.stats.rushing_20_plus,
      rushing_40_plus:           player_stats["40+"]   || player.stats.rushing_40_plus,
      rushing_fumbles:           player_stats["FUM"]   || player.stats.rushing_fumbles
    )
  end
end