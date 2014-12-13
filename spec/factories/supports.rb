FactoryGirl.define do
  factory :support do
    title       "title"
    body        "body"
    association :support_category
  end
end