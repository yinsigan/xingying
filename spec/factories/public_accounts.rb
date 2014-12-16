include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :public_account do
    name    "first_public_account"
    tp      1
    image  { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.png'), 'image/png') }
    association :user
  end
end