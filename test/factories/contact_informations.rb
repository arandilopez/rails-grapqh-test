FactoryBot.define do
  factory :contact_information do
    name { Faker::Name.name }
    email { Faker::Internet.safe_email(name: name) }
    phone { Faker::PhoneNumber.cell_phone }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    employee { nil }
  end
end
