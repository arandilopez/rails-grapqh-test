Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute", as: :graphql
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if Rails.env.development?
end
