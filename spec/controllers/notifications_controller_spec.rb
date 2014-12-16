require "rails_helper"

RSpec.describe NotificationsController, :type => :controller do
  before(:each) do
    user = FactoryGirl.create(:user)
    sign_in user
  end
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #delete" do
    it "responds successfully with an HTTP 200 status code" do
      xhr :get, :delete
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      xhr :get, :delete
      expect(response).to render_template("shared/delete.js.erb")
    end
  end

  describe "delete #clear" do
    it "responds successfully with an HTTP 200 status code" do
      delete :clear
      expect(response).to redirect_to(notifications_path)
    end
  end
end