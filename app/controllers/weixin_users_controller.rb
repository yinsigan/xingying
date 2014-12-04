class WeixinUsersController < SettingsController
  before_action :set_public_account, :appid_present
  def index
    @client ||= WeixinAuthorize::Client.new(@public_account.appid, @public_account.appsecret, @public_account.id)
    if @client.is_valid?
      @weixin_users = Kaminari.paginate_array(@client.followers.result[:data][:openid]).page(params[:page])
      @weixin_users_count = @client.followers.result[:total]
    end
  end

end
