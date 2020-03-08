class Player < ApplicationRecord
  has_one :stats, class_name: "PlayerStatistic"
  validates :name, presence: true
  after_create :create_empty_stats

  private

  def create_empty_stats
    PlayerStatistic.create!(player: self)
  end
end