FactoryBot.define do
  factory :comment do
    association :user
    association :post
    content "Test Comment Text"
  end
end
