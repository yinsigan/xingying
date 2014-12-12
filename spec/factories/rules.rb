FactoryGirl.define do
  factory :rule do
    name       "name"
    association :public_account
  end
end