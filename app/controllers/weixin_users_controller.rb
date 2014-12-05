class WeixinUsersController < SettingsController
  before_action :set_public_account, :appid_present
  def index
    add_breadcrumb I18n.t("breadcrumbs.weixin_user.index"), :public_account_weixin_users_path
  end

  def request_users
    @client ||= WeixinAuthorize::Client.new(@public_account.appid, @public_account.appsecret, @public_account.id)
    if @client.is_valid?
      @users = Kaminari.paginate_array(@client.followers.result[:data][:openid]).page(params[:page]).per(20)
      @weixin_users = @users.map{|f| @client.user f}
      @weixin_users_count = @client.followers.result[:total]
    end
    if params[:page].present?
      render "request_users_page.js.erb", layout: false
    else
      render "request_users", layout: false
    end
  end

  def edit
    @nickname = params[:nickname]
    @openid = params[:id]
    render "edit.js.erb", layout: false
  end

  # 修改备注，已弃用
  def remark
    @client ||= WeixinAuthorize::Client.new(@public_account.appid, @public_account.appsecret, @public_account.id)
    if @client.is_valid?
      flash = request_menu_result @client.send(:http_post, "/user/info/updateremark", {openid: params[:openid], remark: params[:remark]})
    else
      flash = {warning: t("access_token_error", public_account_id: @public_account.id)}
    end
    redirect_via_turbolinks_to public_account_weixin_users_path(@public_account),
      flash: flash
  end

  def move

  end

  def move_groups

  end

  private

  def request_menu_result(result)
    if result.is_ok?
      flash = {success: t('success_request')}
    else
      flash = {warning: result.full_error_message}
    end
  end
end
