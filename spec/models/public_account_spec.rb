require 'rails_helper'

RSpec.describe PublicAccount do
  let (:user) { FactoryGirl.create(:user) }
  let (:public_account) { FactoryGirl.create(:public_account) }
  subject { public_account }

  it { should respond_to(:name) }
  it { should respond_to(:tp) }
  it { should respond_to(:user) }
  it { should respond_to(:image) }
  it { should respond_to(:weixin_secret_key) }
  it { should respond_to(:weixin_token) }
  it { should respond_to(:default_reply) }
  it { should respond_to(:pic_text_count) }
  it { should respond_to(:thumbs_count) }
  it { should respond_to(:reply_type) }
  it { should respond_to(:autoreply) }
  it { should respond_to(:appid) }
  it { should respond_to(:appsecret) }
  it { should respond_to(:open_customed) }
  it { should respond_to(:default_customed) }
  it { should respond_to(:trigger_custom) }

  it { should respond_to(:sin_materials) }
  it { should respond_to(:multi_materials) }
  it { should respond_to(:rules) }
  it { should respond_to(:thumbs) }
  it { should respond_to(:thumb_groups) }
  it { should respond_to(:kwords) }
  it { should respond_to(:sin_pic_texts) }
  it { should respond_to(:menus) }
  it { should respond_to(:default_sin_material) }
  it { should respond_to(:autoreply_sin_material) }

  it { should respond_to(:incre_sin_material_count) }
  it { should respond_to(:decre_sin_material_count) }

  describe "when name is no present" do
    before { public_account.name = "" }
    it { should_not be_valid }
  end

  describe "when tp is no present" do
    before { public_account.tp = nil }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { public_account.name = "a" * 31 }
    it { should_not be_valid }
  end
end