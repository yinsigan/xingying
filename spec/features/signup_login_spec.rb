require 'rails_helper'

describe "the signin process", :type => :feature do
  before :each do
    User.create(:email => 'yinsigan@example.com', :password => 'password')
  end

  it "signs me in" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'user_email',    :with => 'yinsigan@example.com'
      fill_in 'user_password', :with => 'password'
    end
    click_button '登录'
    expect(page).to have_content '登录成功'
  end
end

describe "the signup process", :type => :feature do
  before :each do
    User.create(:email => 'user@example.com', :password => 'password')
  end

  it "signups me in" do
    visit '/users/sign_up'
    within("#loginform") do
      fill_in 'user_email',                 :with => 'ganweiliang@example.com'
      fill_in 'user_password',              :with => 'password'
      fill_in 'user_password_confirmation', :with => 'password'
    end
    click_button '保存'
    expect(page).to have_content '您已注册成功'
  end
end
