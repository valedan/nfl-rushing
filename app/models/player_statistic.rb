class PlayerStatistic < ApplicationRecord
  belongs_to :player

  def longest_rush
    touchdown_flag = longest_rush_touchdown ? "T" : nil
    "#{longest_rush_distance}#{touchdown_flag}"
  end
end