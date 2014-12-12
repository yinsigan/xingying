require 'rails_helper'

RSpec.describe User, :type => :model do
  before do
    @user = User.new(email: "903279182@qq.com",
                     password: "12345678",
                     password_confirmation: "12345678")
  end

  subject { @user }

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
end
