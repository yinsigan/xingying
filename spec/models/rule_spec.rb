require 'rails_helper'

RSpec.describe Rule do
  let (:public_account) { FactoryGirl.create(:public_account) }
  let (:rule) { FactoryGirl.create(:rule) }
  subject { rule }

  it { should respond_to(:name) }
  it { should respond_to(:public_account) }
  it { should respond_to(:kwords) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:public_account) }

  describe "when name is too long" do
    before { rule.name = "a" * 61 }
    it { should_not be_valid }
  end
end