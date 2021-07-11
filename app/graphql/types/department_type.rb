module Types
  class DepartmentType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :company_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :employees, Types::EmployeeType.connection_type, null: true
    def employees
      BatchLoader::GraphQL.for(object.id).batch(default_value: []) do |department_ids, loader|
        Employee.where(department_id: department_ids).each do |employee|
          loader.call(employee.department_id) { |employees| employees << employee }
        end
      end
    end
  end
end
