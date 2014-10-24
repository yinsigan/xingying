class ThumbGroupsController < SettingsController
  before_action :set_public_account
  before_action :thumb_group_params, only: [:create]

  def new
    @thumb_group = @public_account.thumb_groups.build
    render "new.js.erb", layout: false
  end

  def create
    @thumb_group = @public_account.thumb_groups.build(thumb_group_params)
    @thumb_group.save
    render "create.js.erb", layout: false
  end

  private
    def set_public_account
      @public_account = current_user.public_accounts.find(params[:public_account_id])
    end

    def thumb_group_params
      params.require(:thumb_group).permit(:name)
    end

end
