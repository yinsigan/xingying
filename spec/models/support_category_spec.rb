require 'rails_helper'

RSpec.describe SupportCategory do
  let (:support_category) { FactoryGirl.create(:support_category) }

  subject { support_category }

  it { should respond_to(:name) }

  describe "when name is no present" do
    before { support_category.name = "" }
    it { should_not be_valid }
  end

end