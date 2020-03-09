module Types
  class QueryType < Types::BaseObject

    field :players, [PlayerType], null: true do
      description "Get a list of players"
      argument :sortBy, SortBy, required: false
    end

    field :player, PlayerType, null: true do
      description "Find a player by ID"
      argument :id, ID, required: true
    end
  
    def players(sortBy: nil)
      Player.joins(:stats)
            .order("player_statistics.#{sortBy.field.underscore} #{sortBy.order}")
    end

    def player(id:)
      Player.find(id)
    end
  end
end
