class AutoreplyController < SettingsController
  before_action :set_public_account, :add_show_breadcrumb
  before_action :select_thumb_group, only: [:select_thumb_material]

  # 被添加自动回复，根据类型选择对应的素材
  def reply_content
    if params[:public_account] && params[:public_account][:reply_type]
      render PublicAccount::ReplyTypeNode[params[:public_account][:reply_type].to_i] + ".js.erb", layout: false
    end
  end

  def autoreply_content
    if params[:public_account] && params[:public_account][:autoreply_type]
      render "auto_" + PublicAccount::ReplyTypeNode[params[:public_account][:autoreply_type].to_i] + ".js.erb", layout: false
    end
  end

  # 被添加自动回复
  def added
    add_breadcrumb I18n.t("breadcrumbs.autoreply.added"),
      added_public_account_path(@public_account)
    store_location
  end

  # 被添加自动回复的动作
  def set_default_reply
    if  @public_account.update(public_account_params)
      flash[:success] = I18n.t('success_save')
      redirect_to added_public_account_path(@public_account)
    else
      render :added
    end
  end

  # 消息自动回复的动作
  def set_auto_reply
    if  @public_account.update(public_account_params)
      flash[:success] = I18n.t('success_save')
      redirect_to default_public_account_path(@public_account)
    else
      render :default
    end
  end

  # 选择单图文
  def select_sin_material
    @hidden_tag = params[:hidden_tag].presence
    # 预览单图文的wrapper
    @preview_wrapper = params[:preview_wrapper].presence
    # 当在菜单中设置动作可以返回
    @prev_link = params[:prev_link].presence
    # 当执行删除时可以返回
    @select_prev_link = request.original_url
    @sin_materials = @public_account.sin_materials
      .includes(sin_pic_text: [:thumb]).page(params[:page]).per(6)
    render "select_sin_material.js.erb", layout: false
  end

  # 图片显示和分页
  def select_thumb_material
    @select_prev_link = request.original_url
    render "select_thumb_material.js.erb", layout: false
  end

  def default
    add_breadcrumb I18n.t("breadcrumbs.autoreply.default"),
      added_public_account_path(@public_account)
    store_location
  end

  def upload
    @thumb = @public_account.thumbs.build(upload_group_params)
    @thumb.save
    @object = @thumb
    @thumb_group_id =  params[:thumb_group_id].presence
    render "upload.js.erb", layout: false
  end

  private
    def set_public_account
      @public_account = current_user.public_accounts.find(params[:id])
      set_page_title @public_account.name
    end

    def add_show_breadcrumb
      add_breadcrumb @public_account.name, public_account_path(@public_account)
    end

    def public_account_params
      params.require(:public_account).permit(
        :default_reply,
        :reply_type,
        :default_material_id,
        :autoreply,
        :autoreply_type,
        :autoreply_material_id
      )
    end

    def upload_group_params
      params.permit(:thumb_group_id, :image)
    end

    def select_thumb_group
      if params[:thumb_group_id]
        @find_thumb_group = @public_account.thumb_groups.find(params[:thumb_group_id])
        @thumbs = @public_account.thumbs.includes(:thumb_material)
          .where(:thumb_group => @find_thumb_group)
          .page(params[:page]).per(8)
      else
        @thumbs = @public_account.thumbs.includes(:thumb_material)
          .where("thumbs.thumb_group_id IS NULL OR thumbs.thumb_group_id = 0")
          .page(params[:page]).per(3)
      end
      @no_group_count = @public_account.thumbs
        .where("thumbs.thumb_group_id IS NULL OR thumbs.thumb_group_id = 0").count
      @thumb_groups = @public_account.thumb_groups.order("created_at ASC")
    end
end
