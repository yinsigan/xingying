require 'rails_helper'

RSpec.describe Ticket do
  let (:user) { FactoryGirl.create(:user) }
  let (:ticket) { FactoryGirl.create(:ticket) }
  subject { ticket }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:number) }
  it { should respond_to(:status) }
  it { should respond_to(:user) }

  it { should respond_to(:comments) }

  describe "when title is no present" do
    before { ticket.title = "" }
    it { should_not be_valid }
  end

  describe "when body is no present" do
    before { ticket.body = "" }
    it { should_not be_valid }
  end

  describe "when number is no present" do
    before { ticket.number = "" }
    it { should_not be_valid }
  end

  describe "when user is not present" do
    before { ticket.user = nil }
    it { should_not be_valid }
  end
end