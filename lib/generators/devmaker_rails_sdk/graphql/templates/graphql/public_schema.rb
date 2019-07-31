class PublicSchema < GraphQL::Schema
  mutation(Types::Public::MutationType)
  query(Types::Public::QueryType)
end