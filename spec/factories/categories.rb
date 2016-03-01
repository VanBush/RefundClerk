FactoryGirl.define do
  factory :category do
    title { Faker::Commerce.department }
    refund_percentage 50
  end
end
