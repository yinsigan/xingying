class ThumbGroupsController < SettingsController
  before_action :set_public_account
  before_action :thumb_group_params, only: [:create]

  def new
    @thumb_group = @public_account.thumb_groups.build
    render "new.js.erb", layout: false
  end

  def delete
    @delete_url = public_account_thumb_group_path
    @confirm = I18n.t("thumb_groups.delete.confirm")
    @remote = true
    render "shared/delete.js.erb", layout: false
  end

  def destroy
    @thumb_group = @public_account.thumb_groups.find(params[:id])
    @thumb_group.destroy
    redirect_via_turbolinks_to public_account_thumbs_path(@public_account),
      flash: {success: I18n.t('success_delete')}
  end

  def edit
    @thumb_group = @public_account.thumb_groups.find(params[:id])
    render "edit.js.erb", layout: false
  end

  def update
    @thumb_group = @public_account.thumb_groups.find(params[:id])
    @thumb_group.update(thumb_group_params)
    @object = @thumb_group
    render "update.js.erb", layout: false
  end

  def create
    @thumb_group = @public_account.thumb_groups.build(thumb_group_params)
    @thumb_group.save
    @object = @thumb_group
    render "create.js.erb", layout: false
  end

  private
    def set_public_account
      @public_account = current_user.public_accounts.find(params[:public_account_id])
      set_page_title @public_account.name
    end

    def thumb_group_params
      params.require(:thumb_group).permit(:name)
    end

end
