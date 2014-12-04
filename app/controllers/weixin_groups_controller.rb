class WeixinGroupsController < SettingsController
  before_action :set_public_account, :appid_present
  before_action :get_client, only: [:request_groups, :create, :rename]

  def index
    add_breadcrumb I18n.t("breadcrumbs.weixin_group.index"), :public_account_weixin_groups_path
  end

  def request_groups
    if @client.is_valid?
      @weixin_groups = @client.groups.result[:groups]
    end
    render "request_groups", layout: false
  end

  def new
    @group_id   = params[:group_id]
    @group_name = params[:group_name]
    render "new.js.erb", layout: false
  end

  def create
    if @client.is_valid?
      flash = request_menu_result @client.create_group(params[:group_name])
    else
      flash = {warning: t("access_token_error", public_account_id: @public_account.id)}
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
      flash = {warning: t("access_token_error", public_account_id: @public_account.id)}
    end
    redirect_via_turbolinks_to public_account_weixin_groups_path(@public_account),
      flash: flash
  end

  private

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
