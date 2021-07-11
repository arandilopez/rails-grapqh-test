FactoryBot.define do
  factory :employee do
    name { Faker::Name.name }
    email { Faker::Internet.safe_email(name: name) }
    phone { Faker::PhoneNumber.cell_phone }
    role { nil }
    department { nil }
  end
end
