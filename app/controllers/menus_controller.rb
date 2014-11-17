class MenusController < SettingsController
  before_action :set_public_account
  before_action :appid_present, :add_show_breadcrumb

  def index
    @client ||= WeixinAuthorize::Client.new(@public_account.try(:appid), @public_account.try(:appsecret))
    if @client.is_valid?
      @menu = @public_account.menus
    else
      store_location
    end
  end

  def new
    @menu = @public_account.menus.build
    render "new.js.erb", layout: false
  end

  private

  def set_public_account
    @public_account = current_user.public_accounts.find(params[:public_account_id])
    set_page_title @public_account.name
  end

  def add_show_breadcrumb
    add_breadcrumb @public_account.name, public_account_path(@public_account)
  end

  def appid_present
    if !(@public_account.appid.present? && @public_account.appsecret.present?)
      redirect_to edit_public_account_path(@public_account),
        flash: {danger: I18n.t("menus.index.enter_tip")}
      store_location
    end
  end
end
