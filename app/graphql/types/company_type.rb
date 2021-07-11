module Types
  class CompanyType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :address, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :departments, Types::DepartmentType.connection_type, null: true
    def departments
      BatchLoader::GraphQL.for(object.id).batch(default_value: []) do |company_ids, loader|
        Department.where(company_id: company_ids).each do |deparment|
          loader.call(deparment.company_id) { |departments| departments << deparment }
        end
      end
    end

    field :roles, Types::RoleType.connection_type, null: true
    def roles
      BatchLoader::GraphQL.for(object.id).batch(default_value: []) do |company_ids, loader|
        Role.joins(employees: [department: :company]).reselect('roles.*, companies.id as company_id')
            .where('companies.id IN (?)', company_ids).distinct.each do |role|
          loader.call(role.company_id) { |roles| roles << role }
        end
      end
    end
  end
end
