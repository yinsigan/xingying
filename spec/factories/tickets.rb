FactoryGirl.define do
  factory :ticket do
    title       "title"
    body        "body"
    number      "85604719"
    association :user
  end
end