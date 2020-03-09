require "rails_helper"

describe "Players API" do
  describe "Players query" do
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

    it "allows sorting by a field on stats" do
      data = [
        { "Player" => "Joe Banyard", "Att" => 2 },
        { "Player" => "Shaun Hill", "Att" => 5 },
        { "Player" => "Breshad Perriman", "Att" => 1 },
        { "Player" => "Charlie Whitehurst", "Att" => 3 }
      ]
      PlayerDataImporter.call(data)

      query_string = <<-GRAPHQL
        query($sortBy: SortBy){
          players(sortBy: $sortBy) {
            name
            id
            stats {
              rushingAttempts
            }
          }
        }
      GRAPHQL

      sortedResult = Schema.execute(
        query_string, 
        variables: { sortBy: { field: "rushingAttempts", order: "ASC"} }
      )
      reversedResult = Schema.execute(
        query_string, 
        variables: { sortBy: { field: "rushingAttempts", order: "DESC"} }
      )

      expect(sortedResult["data"]["players"].map{|player| player["name"]})
        .to eq data.sort_by{ |player| player["Att"] }.map{|player| player["Player"]}

      expect(reversedResult["data"]["players"].map{|player| player["name"]})
        .to eq data.sort_by{ |player| player["Att"] }.reverse.map{|player| player["Player"]}
    end
  end

  describe "Player query" do
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

end