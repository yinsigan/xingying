require "rails_helper"

RSpec.describe TicketsController, :type => :controller do
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
  describe "GET #all" do
    it "responds successfully with an HTTP 200 status code" do
      get :all
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the all template" do
      get :all
      expect(response).to render_template("index")
    end
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the all template" do
      get :new
      expect(response).to render_template("new")
    end
  end

end