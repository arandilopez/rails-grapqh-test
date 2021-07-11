module Types
    class EmployeeType < Types::BaseObject
        field :id, ID, null: false
        field :name, String, null: true
        field :email, String, null: true
        field :phone, String, null: true
        field :role_id, Integer, null: false
        field :department_id, Integer, null: false
        # field :created_at, GraphQL::Types::ISO8601DateTime, null: false
        # field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

        field :contact_informations, Types::ContactInformationType.connection_type, null: true
        def contact_informations
            BatchLoader::GraphQL.for(object.id).batch(default_value: []) do |employee_ids, loader|
                ContactInformation.where(employee_id: employee_ids).each do |ci|
                    loader.call(ci.employee_id) { |memo| memo << ci }
                end
            end
        end

        field :department, Types::DepartmentType, null: false
        def department
            BatchLoader::GraphQL.for(object.department_id).batch do |department_ids, loader|
                Department.where(id: department_ids).each do |department|
                    loader.call(department.id, department)
                end
            end
        end

        field :role, Types::RoleType, null: false
        def role
            BatchLoader::GraphQL.for(object.role_id).batch do |role_ids, loader|
                Role.where(id: role_ids).each do |role|
                    loader.call(role.id, role)
                end
            end
        end
    end
end
