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
end