module Types
  class DepartmentType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :company_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :employees, Types::EmployeeType.connection_type, null: true
  end
end
