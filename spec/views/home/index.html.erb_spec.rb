require 'rails_helper'

RSpec.describe "home/index", :type => :view do
  let (:user) { FactoryGirl.create(:user) }
  it "when user have not login" do
    assign(:contact, Contact.new)
    render
    expect(rendered).to match /微场景/
  end

  it "when user have login" do
    user = FactoryGirl.create(:user)
    sign_in user
    # TODO
  end
end
