class RailsGraphqlNplus1Schema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  default_max_page_size 50
end
