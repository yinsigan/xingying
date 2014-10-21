class ThumbsController < SettingsController
  skip_before_action :verify_authenticity_token
  before_action :set_public_account, only: [:index, :create]
  def create
    @thumb = @public_account.thumbs.new
    @thumb.image = params[:image]
    @thumb.save
    render "create.js.erb", layout: false
  end

  def index
    @thumbs = @public_account.thumbs
  end

  private
    def set_public_account
      @public_account = current_user.public_accounts.find(params[:public_account_id])
    end
end
