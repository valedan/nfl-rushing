require "rails_helper"

describe "Players API" do
  # TODO: Now that the query logic has been moved from the GraphQL query class to the PlayerQuery service object, consider moving/refactoring these tests.
  describe "Players query" do
    it "fetches a list of all players" do
      query_string = <<-GRAPHQL
        query{
          players {
            totalCount
            nodes {
              name
              id
              stats{
                rushingAttempts
              }
            }
          }
        }
      GRAPHQL
  
      players = create_list(:player, 5)
      PlayerStatistic.update_all(rushing_attempts: 10)
      result = Schema.execute(query_string)

      player_result = result["data"]["players"]["nodes"]
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
            nodes {
              name
              id
              stats {
                rushingAttempts
              }
            }
          }
        }
      GRAPHQL

      sorted_result = Schema.execute(
        query_string, 
        variables: { sortBy: { field: "rushingAttempts", order: "ASC"} }
      )
      reversed_result = Schema.execute(
        query_string, 
        variables: { sortBy: { field: "rushingAttempts", order: "DESC"} }
      )

      sorted_data = sorted_result["data"]["players"]["nodes"]
      reversed_data = reversed_result["data"]["players"]["nodes"]
      expect(sorted_data.map{|player| player["name"]})
        .to eq data.sort_by{ |player| player["Att"] }.map{|player| player["Player"]}

      expect(reversed_data.map{|player| player["name"]})
        .to eq data.sort_by{ |player| player["Att"] }.reverse.map{|player| player["Player"]}
    end

    it "allows paginated queries" do
      data = [
        { "Player" => "Joe Banyard", "Att" => 2 },
        { "Player" => "Shaun Hill", "Att" => 5 },
        { "Player" => "Breshad Perriman", "Att" => 1 },
        { "Player" => "Charlie Whitehurst", "Att" => 3 }
      ]
      PlayerDataImporter.call(data)

      query_string = <<-GRAPHQL
        query($limit: Int, $offset: Int){
          players(limit: $limit, offset: $offset) {
              totalCount
              nodes {
                name
                id
                stats {
                  rushingAttempts
                }
              }
          }
        }
      GRAPHQL

      result = Schema.execute(query_string, variables: { limit: 2, offset: 2 })
      expect(result["data"]["players"]["totalCount"]).to eq 4
      expect(result["data"]["players"]["nodes"].map{|player| player["name"]})
        .to eq data.last(2).map{|player| player["Player"]}
    end

    it "allows filtering by player name" do
      data = [
        { "Player" => "Joe Banyard", "Att" => 2 },
        { "Player" => "Shaun Hill", "Att" => 5 },
        { "Player" => "Breshad Perriman", "Att" => 1 },
        { "Player" => "Joe Whitehurst", "Att" => 3 }
      ]

      PlayerDataImporter.call(data)

      query_string = <<-GRAPHQL
        query($nameFilter: String){
          players(nameFilter: $nameFilter) {
              totalCount
              nodes {
                name
              }
          }
        }
      GRAPHQL

      result = Schema.execute(query_string, variables: { nameFilter: "joe" })
      expect(result["data"]["players"]["totalCount"]).to eq 2
      expect(result["data"]["players"]["nodes"].map{|player| player["name"]})
        .to eq ["Joe Banyard", "Joe Whitehurst"]
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