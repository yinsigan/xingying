FactoryGirl.define do
  factory :notification do
    subject     "subject"
    body        "body"
    association :user
    factory :system_notification do
      tp    0
    end
    factory :ticket_comment_notification do
      tp    1
    end
  end
end