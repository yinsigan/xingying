require 'rails_helper'

RSpec.describe Support do
  let (:support_category) { FactoryGirl.create(:support_category) }
  let (:support) { FactoryGirl.create(:support) }

  subject { support }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:support_category) }

  describe "when title is no present" do
    before { support.title = "" }
    it { should_not be_valid }
  end

  describe "when body is no present" do
    before { support.body = "" }
    it { should_not be_valid }
  end

end