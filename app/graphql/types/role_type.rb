module Types
  class RoleType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :employees, Types::EmployeeType.connection_type, null: false
    def employees
      BatchLoader::GraphQL.for(object.id).batch(default_value: []) do |role_ids, loader|
        # If the this field is required without a parent company, let's just return an empty
        # array instead of all employees
        if object.company_id.blank?
          loader.call(object.id, [])
        else
          # This way we can return just the employees scoped by the company -> role
          Employee.joins(department: :company)
                  .where('companies.id = ?', object.company_id)
                  .where(role_id: role_ids)
                  .distinct.each do |employee|
            loader.call(employee.role_id) { |employees| employees << employee }
          end
        end
      end
    end
  end
end
