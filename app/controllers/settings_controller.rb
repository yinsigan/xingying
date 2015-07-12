class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize
  before_action :home_breadcrumb
  layout "settings"
  include SettingsHelper

  protected

  def set_public_account
    @public_account = current_user.public_accounts.find(params[:public_account_id])
    set_page_title @public_account.name
    add_breadcrumb @public_account.name, public_account_path(@public_account)
  end

  def appid_present
    if !(@public_account.appid.present? && @public_account.appsecret.present?)
      redirect_to edit_public_account_path(@public_account),
        flash: {danger: I18n.t("menus.index.enter_tip")}
      store_location
    end
  end

  private

  def home_breadcrumb
    add_breadcrumb I18n.t('home'), :root_path
  end

  def authorize
    if current_user.super_admin?
      Rack::MiniProfiler.authorize_request
    end
  end
end
