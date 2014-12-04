class WeixinUsersController < SettingsController
  before_action :set_public_account, :appid_present
  def index
    @client ||= WeixinAuthorize::Client.new(@public_account.appid, @public_account.appsecret, @public_account.id)
    if @client.is_valid?
      @users = @client.followers.result[:data][:openid]
      @users_count = @client.followers.result[:total]
    end
  end

end
