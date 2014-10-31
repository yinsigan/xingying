class AutoreplyController < SettingsController
  before_action :set_public_account, :add_show_breadcrumb

  def reply_content
    if params[:public_account] && params[:public_account][:reply_type]
      render PublicAccount::ReplyTypeNode[params[:public_account][:reply_type].to_i] + ".js.erb", layout: false
    end
  end

  def added
    add_breadcrumb I18n.t("breadcrumbs.autoreply.added"), added_public_account_path(@public_account)
    store_location
  end

  def set_default_reply
    if  @public_account.update(public_account_params)
      flash[:success] = I18n.t('success_save')
      redirect_to added_public_account_path(@public_account)
    else
      render :added
    end
  end

  def select_sin_material
    @sin_materials = @public_account.sin_materials.includes(sin_pic_text: [:thumb]).page(params[:page]).per(6)
    render "select_sin_material.js.erb", layout: false
  end

  def select_thumb_material
    if params[:thumb_group_id]
      @find_thumb_group = @public_account.thumb_groups.find(params[:thumb_group_id])
      @thumbs = @public_account.thumbs.where(:thumb_group => @find_thumb_group).page(params[:page]).per(8)
    else
      @thumbs = @public_account.thumbs.where("thumbs.thumb_group_id IS NULL OR thumbs.thumb_group_id = 0").page(params[:page]).per(8)
    end
    render "select_thumb_material.js.erb", layout: false
  end

  def default
  end

  private
    def set_public_account
      @public_account = current_user.public_accounts.find(params[:id])
    end

    def add_show_breadcrumb
      add_breadcrumb @public_account.name, public_account_path(@public_account)
    end

    def public_account_params
      params.require(:public_account).permit(:default_reply, :reply_type, :default_material_id)
    end
end
