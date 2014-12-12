require 'rails_helper'

RSpec.describe Rule do
  let (:public_account) { FactoryGirl.create(:public_account) }
  let (:rule) { FactoryGirl.create(:rule) }
  subject { rule }

  it { should respond_to(:name) }
  it { should respond_to(:public_account) }
  it { should respond_to(:kwords) }

  describe "when name is no present" do
    before { rule.name = "" }
    it { should_not be_valid }
  end

  describe "when public_account is no present" do
    before { rule.public_account = nil }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { rule.name = "a" * 61 }
    it { should_not be_valid }
  end
end