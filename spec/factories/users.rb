FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    full_name { Faker::Name.name }
    admin false
  end
end
