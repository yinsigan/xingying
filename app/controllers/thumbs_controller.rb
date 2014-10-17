class ThumbsController < SettingsController
  skip_before_action :verify_authenticity_token
  def create
    @public_account = current_user.public_accounts.find(params[:public_account_id])
    @thumb = @public_account.thumbs.new
    @thumb.image = params[:image]
    @thumb.save
    render "create.js.erb", layout: false
  end
end
