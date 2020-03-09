class Types::PaginatedConnection < GraphQL::Types::Relay::BaseConnection
  field :total_count, Integer, null: false

  def total_count
    context[:total_query_count]
  end
end