class ThumbsController < SettingsController
  def create
    @public_account = current_user.public_accounts.find(params[:public_account_id])
  end
end
