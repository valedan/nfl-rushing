class PlayersController < ApplicationController

  def export
    sort_by = OpenStruct.new({ field: params[:orderBy], order: params[:order] })
    player_query = PlayerQuery.call(sortBy: sort_by, nameFilter: params[:nameInput])

    csv_data = PlayerStatsExporter.call(player_query)
    send_data(csv_data, filename: "player-stats.csv")
  end
end