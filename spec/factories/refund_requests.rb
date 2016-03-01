FactoryGirl.define do
  factory :refund_request do
    title { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    amount { Faker::Number.decimal(3, 2) }
    status :pending
  end
end
