FactoryGirl.define do
  factory :thumb_group do
    name       "name"
    association :public_account
  end
end