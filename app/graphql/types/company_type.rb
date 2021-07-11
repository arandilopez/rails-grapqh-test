module Types
  class CompanyType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :address, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :departments, [Types::DepartmentType], null: true

    field :roles, [Types::RoleType], null: true
    def roles
      Role.joins(employees: [department: :company]).where('companies.id = ?', object.id).distinct
    end
  end
end
