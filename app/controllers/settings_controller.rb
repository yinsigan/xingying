class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :home_breadcrumb
  layout "settings"
  include SettingsHelper

  private

    def home_breadcrumb
      add_breadcrumb I18n.t('home'), :root_path
    end
end
