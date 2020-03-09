module Types
  class SortBy < Types::BaseInputObject
    argument :field, String, required: true
    argument :order, Types::Order, required: true
  end
end