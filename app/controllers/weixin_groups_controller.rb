class WeixinGroupsController < SettingsController
  before_action :set_public_account, :appid_present

  def index
    add_breadcrumb I18n.t("breadcrumbs.weixin_group.index"), :public_account_weixin_groups_path
    @client ||= WeixinAuthorize::Client.new(@public_account.appid, @public_account.appsecret, @public_account.id)
    @weixin_groups = @client.groups.result[:groups]
  end

  def new
    @group_name = params[:group_name]
    render "new.js.erb", layout: false
  end

  def create
  end

  def edit
  end

  def update
  end

  private
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
end
