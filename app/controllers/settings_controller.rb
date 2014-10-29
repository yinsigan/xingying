class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :home_breadcrumb
  layout "settings"
  include SettingsHelper

  private

    def home_breadcrumb
      add_breadcrumb "首页", :root_path
    end
end
