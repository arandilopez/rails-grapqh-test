FactoryBot.define do
  factory :department do
    name { Faker::Job.field }
    company { nil }
  end
end
