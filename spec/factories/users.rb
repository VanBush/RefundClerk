FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| Faker::Internet.free_email("user#{n}") }
    password { Faker::Internet.password }
    full_name { Faker::Name.name }
    admin false
  end
end
