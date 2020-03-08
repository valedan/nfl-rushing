FactoryBot.define do
  factory :player do
    name { Faker::Sports::Football.player }
  end

  factory :player_statistic do
  end
end