module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :companies, Types::CompanyType.connection_type, null: false
    def companies
      Company.all
    end
  end
end
