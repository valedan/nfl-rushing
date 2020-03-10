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
    new_data = {
      rushing_attempts:          player_stats["Att"]    || player.stats.rushing_attempts,
      rushing_attempts_per_game: player_stats["Att/G"]  || player.stats.rushing_attempts_per_game,
      total_rushing_yards:       player_stats["Yds"]    || player.stats.total_rushing_yards,
      rushing_yards_per_attempt: player_stats["Avg"]    || player.stats.rushing_yards_per_attempt,
      rushing_yards_per_game:    player_stats["Yds/G"]  || player.stats.rushing_yards_per_game,
      total_rushing_touchdowns:  player_stats["TD"]     || player.stats.total_rushing_touchdowns,
      rushing_first_downs:       player_stats["1st"]    || player.stats.rushing_first_downs,
      rushing_first_down_pct:    player_stats["1st%"]   || player.stats.rushing_first_down_pct, 
      rushing_20_plus:           player_stats["20+"]    || player.stats.rushing_20_plus,
      rushing_40_plus:           player_stats["40+"]    || player.stats.rushing_40_plus,
      rushing_fumbles:           player_stats["FUM"]    || player.stats.rushing_fumbles
    }

    if player_stats["Lng"].present?
      new_data = new_data.merge(parse_longest_rush(player_stats))
    end
    player.stats.update!(new_data)
  end

  def parse_longest_rush(player_stats)
    longest_rush = player_stats["Lng"].to_s
    touchdown = longest_rush.include?("T")
    distance = longest_rush.split('T').first.to_i
    return { longest_rush_distance: distance, longest_rush_touchdown: touchdown }
  end
end