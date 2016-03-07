FactoryGirl.define do
  factory :category do
    sequence(:title) { |n| "Faker::Commerce.department #{n}" }
    refund_percentage 50
  end
end
