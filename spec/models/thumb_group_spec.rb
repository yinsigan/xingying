require 'rails_helper'

RSpec.describe ThumbGroup do
  let (:public_account) { FactoryGirl.create(:public_account) }
  let (:thumb_group) { FactoryGirl.create(:thumb_group) }
  subject { thumb_group }

  it { should respond_to(:name) }
  it { should respond_to(:public_account) }

  describe "when name is no present" do
    before { thumb_group.name = "" }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { thumb_group.name = "a" * 10 }
    it { should_not be_valid }
  end

end