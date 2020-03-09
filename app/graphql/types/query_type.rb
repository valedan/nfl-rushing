module Types
  class QueryType < Types::BaseObject

    field :players, PlayerType.connection_type, null: true do
      description "Get a list of players"
      argument :sortBy, SortBy, required: false
      argument :limit, Int, required: false
      argument :offset, Int, required: false
    end

    field :player, PlayerType, null: true do
      description "Find a player by ID"
      argument :id, ID, required: true
    end
  
    def players(**args)
      PlayerQuery.call(context, args)
    end

    def player(id:)
      Player.find(id)
    end
  end
end
