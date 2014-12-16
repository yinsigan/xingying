FactoryGirl.define do
  factory :user do
    email                    "903279182@qq.com"
    password                 "12345678"
    password_confirmation    "12345678"
    factory :other_user do
      email                  "690553145@qq.com"
    end
  end

end