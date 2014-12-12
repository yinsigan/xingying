require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { FactoryGirl.create(:user) }

  subject { user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:encrypted_password) }
  it { should respond_to(:reset_password_token) }
  it { should respond_to(:reset_password_sent_at) }
  it { should respond_to(:remember_created_at) }
  it { should respond_to(:sign_in_count) }
  it { should respond_to(:current_sign_in_at) }
  it { should respond_to(:last_sign_in_at) }
  it { should respond_to(:current_sign_in_ip) }
  it { should respond_to(:last_sign_in_ip) }
  it { should respond_to(:role) }
  it { should respond_to(:confirmation_token) }
  it { should respond_to(:confirmed_at) }
  it { should respond_to(:confirmation_sent_at) }
  it { should respond_to(:invitation_token) }
  it { should respond_to(:invitation_created_at) }
  it { should respond_to(:invitation_sent_at) }
  it { should respond_to(:invitation_accepted_at) }
  it { should respond_to(:invitation_limit) }
  it { should respond_to(:invited_by_id) }
  it { should respond_to(:invited_by_type) }
  it { should respond_to(:invitations_count) }
  it { should respond_to(:password_salt) }

  it { should respond_to(:public_accounts) }
  it { should respond_to(:tickets) }
  it { should respond_to(:comments) }
  it { should respond_to(:notifications) }
  it { should respond_to(:invitations) }

  it { should respond_to(:can_admin?) }
  it { should respond_to(:role_enum) }
  it { should respond_to(:role=) }

  it { should be_valid }
  it { should_not be_admin }
  it { should_not be_super_admin }

  describe "with role attribute set to admin" do
    before do
      user.save!
      user.admin!
    end
    it { should be_admin }
  end

  describe "with role attribute set to superadmin" do
    before do
      user.save!
      user.super_admin!
    end
    it { should be_super_admin }
  end

  describe "when email is not present" do
    before { user.email = "" }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { user.password = "" }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses =  %w{invalid_email_format 123 $$$ () ☃ bla@bla.}
      addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid
      end
    end
  end

  describe "when email is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
  end

  describe "when password doesn't match confirmaion" do
    before { user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before {user.password = user.password_confirmation = "a" * 5 }
    it { should_not be_valid }
  end

  describe "public_accounts associations" do
    before { user.save }
    let!(:public_account) do
      FactoryGirl.create(:public_account, user: user)
    end

    it "should destroy associated public_accounts" do
      public_accounts = user.public_accounts.to_a
      user.destroy
      expect(public_accounts).not_to be_empty
    end
  end

end
