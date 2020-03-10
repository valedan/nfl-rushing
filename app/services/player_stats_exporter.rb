class PlayerStatsExporter < ApplicationService
  def initialize(query)
    @query = query
  end

  def call
    headers = %w{ 
      Player Team Pos Att Att/G Yds Avg Yds/G TD Lng 1st 1st% 20+ 40+ FUM
    }

    CSV.generate(headers: true) do |csv|
      csv << headers
      # Can't use find_each here because it doesn't retain sort order.
      # This means we're storing all of the queried records in memory
      # Probably not a huge problem for 10k records
      # But would definitely need to be solved if the table got much bigger
      @query.each do |player|
        csv << generate_row(player)
      end
    end
  end

  def generate_row(player)
    [
      player.name,
      player.team,
      player.position,
      player.stats.rushing_attempts,
      player.stats.rushing_attempts_per_game,
      player.stats.total_rushing_yards,
      player.stats.rushing_yards_per_attempt,
      player.stats.rushing_yards_per_game,
      player.stats.total_rushing_touchdowns,
      player.stats.longest_rush,
      player.stats.rushing_first_downs,
      player.stats.rushing_first_down_pct,
      player.stats.rushing_20_plus,
      player.stats.rushing_40_plus,
      player.stats.rushing_fumbles
    ]
  end
end