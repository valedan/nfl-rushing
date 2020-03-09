module Types
  class BaseObject < GraphQL::Schema::Object
    field_class Types::BaseField
    connection_type_class Types::PaginatedConnection
  end
end
