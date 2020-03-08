require "rails_helper"

describe PlayerDataImporter do
  it "imports valid data" do
    valid_data = [
      {
        "Player" => "Joe Banyard",
        "Team" => "JAX",
        "Pos" => "RB",
        "Att" => 2,
        "Att/G" => 2,
        "Yds" => 7,
        "Avg" => 3.5,
        "Yds/G" => 7,
        "TD" => 0,
        "Lng" => "7",
        "1st" => 0,
        "1st%" => 0,
        "20+" => 0,
        "40+" => 0,
        "FUM" => 0
      },
      # Player name is the only required field
      {
        "Player" => "Shaun Hill"
      }
    ]

    expected_stats = {
      rushing_attempts: 2,
      rushing_attempts_per_game: 2,
      total_rushing_yards: 7,
      rushing_yards_per_attempt: 3.5,
      rushing_yards_per_game: 7,
      total_rushing_touchdowns: 0,
      longest_rush: "7",
      rushing_first_downs: 0,
      rushing_first_down_pct: 0, 
      rushing_20_plus: 0,
      rushing_40_plus: 0,
      rushing_fumbles: 0
    }

    PlayerDataImporter.call(valid_data)

    expect(Player.all.pluck(:name)).to contain_exactly("Joe Banyard", "Shaun Hill")
    expect(Player.first.stats.attributes.symbolize_keys.except(:id, :player_id)).to eq expected_stats
  end

  context "When a player already exists in the database" do
    it "updates the player's stats" do
      player = Player.create!(name: "Colin Kaepernick")
      player.stats.update!(rushing_attempts: 10, total_rushing_yards: 20)
      duplicate_data = [{ "Player" => "Colin Kaepernick", "Att" => 5 }]

      PlayerDataImporter.call(duplicate_data)

      expect(Player.last.stats.slice(:rushing_attempts, :total_rushing_yards))
        .to eq({ "rushing_attempts" => 5, "total_rushing_yards" => 20 })
    end
  end

  context "When some data is invalid" do
    it "raises an error and does not persist any data" do
      invalid_data = [
        # first record is valid
        {
          "Player" => "Joe Banyard",
        },
        {
          "Player" => "",
          "Team" => "CLE"
        }
      ]

      expect{PlayerDataImporter.call(invalid_data)}.to raise_error(ActiveRecord::RecordInvalid)
      expect(Player.count).to eq 0
    end
  end
end