module Types
  class QueryType < Types::BaseObject

    field :players, [PlayerType], null: true do
      description "Get a list of players"
    end

    field :player, PlayerType, null: true do
      description "Find a player by ID"
      argument :id, ID, required: true
    end
  
    def players
      Player.all
    end

    def player(id:)
      Player.find(id)
    end
  end
end
