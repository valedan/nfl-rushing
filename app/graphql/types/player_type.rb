module Types
  class PlayerType < Types::BaseObject
    description "An NFL player"
    field :id, ID, null: false
    field :name, String, null: false
    field :team, String, null: true
    field :position, String, null: true
    field :stats, Types::PlayerStatisticType, null: true,
      description: "This player's statistics"
  end
end