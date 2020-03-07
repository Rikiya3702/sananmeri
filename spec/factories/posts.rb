FactoryBot.define do
  factory :post do
    association :user
    title "Test_Title"
    content "Content"
    public true
  end
end
