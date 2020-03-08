require "rails_helper"

describe "Players API" do
  it "fetches a list of all players" do
    query_string = <<-GRAPHQL
      query{
        players {
          name
          id
          stats{
            rushingAttempts
          }
        }
      }
    GRAPHQL

    players = create_list(:player, 5)
    PlayerStatistic.update_all(rushing_attempts: 10)
    result = Schema.execute(query_string)

    player_result = result["data"]["players"]
    expect(players.map{|player| player.id.to_s})
      .to match_array player_result.map{|player| player["id"]}

    expect(players.map{|player| player.name})
      .to match_array player_result.map{|player| player["name"]}

    expect(PlayerStatistic.all.pluck(:rushing_attempts))
      .to eq player_result.map{|player| player["stats"]["rushingAttempts"]}
  end

  it "fetches players by ID" do
    query_string = <<-GRAPHQL
      query($id: ID!){
        player(id: $id) {
          name
          id
          stats{
            rushingAttempts
          }
        }
      }
    GRAPHQL

    player = create(:player)
    player.stats.update!(rushing_attempts: 5)
    result = Schema.execute(query_string, variables: { id: player.id })

    player_result = result["data"]["player"]
    expect(player.id.to_s).to eq player_result["id"]
    expect(player.name).to eq player_result["name"]
    expect(player.stats.rushing_attempts)
      .to eq player_result["stats"]["rushingAttempts"]
  end
end