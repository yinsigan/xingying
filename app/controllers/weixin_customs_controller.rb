class WeixinCustomsController < SettingsController
  before_action :set_public_account, :appid_present
  before_action :get_client, only: [:request_customs, :create, :rename, :trash]
  def index
    add_breadcrumb I18n.t("breadcrumbs.weixin_custom.index"), :public_account_weixin_customs_path
  end

  def request_customs
    if @client.is_valid?
      @weixin_customs = @client.send(:http_post, "/customservice/getkflist", {}).result[:kf_list]
    end
    render "request_customs", layout: false
  end

  def new
    @title = I18n.t("weixin_customs.form.title_new")
    @new = true
  end

  def create
    send_request(@client.send(:http_post,
      "/customservice/kfaccount/add",
      JSON.dump({kf_account: params[:kf_account], nickname: params[:nickname], password: Digest::MD5.hexdigest(params[:password])}),
      {},
      "customservice"))
  end

  def edit
    @nickname   = params[:nickname]
    @kf_account = params[:id]
    @title = I18n.t("weixin_customs.form.title_edit")
  end

  def rename
    send_request(@client.send(:http_post,
      "/customservice/kfaccount/update",
      JSON.dump({kf_account: params[:kf_account], nickname: params[:nickname], password: Digest::MD5.hexdigest(params[:password])}),
      {},
      "customservice"))
  end

  def delete
    @kf_account = params[:id]
  end

  def trash
    if @client.is_valid?
      uri = URI("https://api.weixin.qq.com/customservice/kfaccount/del?access_token=#{@client.get_access_token}&kf_account=#{params[:id]}")
      flash = Net::HTTP.get(uri)
      if JSON.load(flash)["errcode"] == 0
        flash = {success: t('success_request')}
      else
        flash = {warning: flash.to_s}
      end
    else
      flash = {warning: t("access_token_error", public_account_id: @public_account.id)}
    end
    redirect_via_turbolinks_to public_account_weixin_customs_path(@public_account),
      flash: flash
  end

  private

  def request_result(result)
    if result.is_ok?
      flash = {success: t('success_request')}
    else
      flash = {warning: result.full_error_message}
    end
  end
  def get_client
    @client ||= WeixinAuthorize::Client.new(@public_account.appid, @public_account.appsecret, @public_account.id)
  end

  def send_request(method)
    if @client.is_valid?
      flash = request_result method
    else
      flash = {warning: t("access_token_error", public_account_id: @public_account.id)}
    end
    redirect_via_turbolinks_to public_account_weixin_customs_path(@public_account),
      flash: flash
  end
end

module WeixinAuthorize
  class << self
    def customservice_endpoint()
      "https://api.weixin.qq.com"
    end
  end
end