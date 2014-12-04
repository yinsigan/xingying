class WeixinGroupsController < SettingsController
  before_action :set_public_account, :appid_present
  before_action :get_client, only: [:index, :create, :rename]

  def index
    add_breadcrumb I18n.t("breadcrumbs.weixin_group.index"), :public_account_weixin_groups_path
    if @client.is_valid?
      @weixin_groups = @client.groups.result[:groups]
    end
  end

  def new
    @group_id   = params[:group_id]
    @group_name = params[:group_name]
    render "edit.js.erb", layout: false
  end

  def create
    if @client.is_valid?
      flash = request_menu_result @client.create_group(params[:group_name])
    else
      flash = {warning: t("menus.check_publish_menu.access_token_error", public_account_id: @public_account.id)}
    end
    redirect_via_turbolinks_to public_account_weixin_groups_path(@public_account),
      flash: flash
  end

  def edit
    @group_name = params[:group_name]
    render "edit.js.erb", layout: false
  end

  def rename
    if @client.is_valid?
      flash = request_menu_result @client.update_group_name(params[:id], params[:group_name])
    else
      flash = {warning: t("menus.check_publish_menu.access_token_error", public_account_id: @public_account.id)}
    end
    redirect_via_turbolinks_to public_account_weixin_groups_path(@public_account),
      flash: flash
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

  def request_menu_result(result)
    if result.is_ok?
      flash = {success: t('success_request')}
    else
      flash = {warning: result.full_error_message}
    end
  end

  def get_client
    @client ||= WeixinAuthorize::Client.new(@public_account.appid, @public_account.appsecret, @public_account.id)
  end
end
