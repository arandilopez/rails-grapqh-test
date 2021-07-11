# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

include FactoryBot::Syntax::Methods

roles = create_list(:role, 10)

create_list(:company, 50).each do |company|
  create_list(:department, (1..5).to_a.sample, company: company).each do |department|
    (10..60).to_a.sample.times do
      create(:employee, department: department, role: roles.sample) do |employee|
        create_list(:contact_information, (1..6).to_a.sample, employee: employee)
      end
    end
  end
end
