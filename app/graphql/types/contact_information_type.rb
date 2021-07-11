module Types
  class ContactInformationType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :email, String, null: true
    field :phone, String, null: true
    field :address, String, null: true
    field :city, String, null: true
    field :state, String, null: true
    field :employee_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :employee, Types::EmployeeType, null: false
  end
end
