class USERNAMESchema < GraphQL::Schema
  mutation(Types::USERNAME::MutationType)
  query(Types::USERNAME::QueryType)
end