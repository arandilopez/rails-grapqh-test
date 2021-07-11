module Types
    class EmployeeType < Types::BaseObject
        field :id, ID, null: false
        field :name, String, null: true
        field :email, String, null: true
        field :phone, String, null: true
        field :role_id, Integer, null: false
        field :department_id, Integer, null: false
        field :created_at, GraphQL::Types::ISO8601DateTime, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

        field :contact_informations, Types::ContactInformationType.connection_type, null: true

        field :department, Types::DepartmentType, null: false

        field :role, Types::RoleType, null: false
    end
end
