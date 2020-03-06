require "rails_helper"

describe PlayerStatistic, type: :model do
  it { should belong_to(:player) }
end