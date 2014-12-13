require "rails_helper"

RSpec.describe HomeController, :type => :controller do
  describe "GET #index" do
    let (:user) { FactoryGirl.create(:user) }
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "should have person navbar if user is signed in" do
      sign_in user
      get :index
      expect(response).to be_success
    end
  end
end