require 'rails_helper'

RSpec.describe Notification do
  let (:user) { FactoryGirl.create(:other_user) }
  let (:notification) { FactoryGirl.create(:system_notification, messageable: user) }
  subject { notification }

  it { should respond_to(:subject) }
  it { should respond_to(:body) }
  it { should respond_to(:tp) }
  it { should respond_to(:readed) }

  it { should respond_to(:messageable) }
  it { should respond_to(:user) }

end