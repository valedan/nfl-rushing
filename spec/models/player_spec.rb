require "rails_helper"

describe Player, type: :model do
  it { should have_one(:stats) }
  it { should validate_presence_of(:name) }

  describe "After creation" do
    it "creates a stats record" do
      Player.create!(name: "Eric Reid")
      expect(PlayerStatistic.last.player.name).to eq "Eric Reid"
    end
  end

end