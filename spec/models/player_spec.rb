require "rails_helper"

describe Player, type: :model do
  it { should have_many(:player_statistics) }
end