class ThumbsController < SettingsController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :set_public_account
  before_action :add_index_breadcrumb, only: [:index]


  def index
    if params[:thumb_group_id]
      @find_thumb_group = @public_account.thumb_groups.find(params[:thumb_group_id])
      @thumbs = @public_account.thumbs.includes(:thumb_material)
        .where(:thumb_group => @find_thumb_group)
        .page(params[:page]).per(8)
    else
      @thumbs = @public_account.thumbs.includes(:thumb_material)
        .where("thumbs.thumb_group_id IS NULL OR thumbs.thumb_group_id = 0")
        .page(params[:page]).per(8)
    end
    @no_group_count = @public_account.thumbs
      .where("thumbs.thumb_group_id IS NULL OR thumbs.thumb_group_id = 0").count
    @thumb_group = @public_account.thumb_groups.build
    @thumb_groups = @public_account.thumb_groups.order("created_at ASC")

    if request.xhr?
      @select_prev_link = request.original_url
      render "select_thumb.js.erb", layout: false
    else
      render :index
    end
  end

  def delete
    @select_prev_link = params[:select_prev_link].presence
    @delete_url = public_account_thumb_path(select_prev_link: @select_prev_link)
    @confirm = I18n.t('thumbs.delete.confirm')
    @remote = true
    render "shared/delete.js.erb", layout: false
  end

  def destroy
    @select_prev_link = params[:select_prev_link].presence
    @thumb = @public_account.thumbs.find(params[:id])
    @thumb.destroy
    render "shared/success_destroy.js.erb", layout: false
  end

  def delete_all
    @delete_url = destroy_all_public_account_thumbs_path(@public_account)
    @confirm = I18n.t('thumbs.delete_all.confirm')
    @remote = true
    render "shared/delete_all.js.erb", layout: false
  end

  def destroy_all
    @public_account.thumbs.where(id: params[:ids]).destroy_all
    render "shared/success_destroy.js.erb", layout: false
  end

  # 在图片列表中上传
  def upload
    @thumb = @public_account.thumbs.build(upload_group_params)
    @thumb.save
    @object = @thumb
    render "upload.js.erb", layout: false
  end

  # 选择图片时上传
  def select_upload
    @thumb = @public_account.thumbs.build(upload_group_params)
    @thumb.save
    @object = @thumb
    @thumb_group_id =  params[:thumb_group_id].presence
    render "select_upload.js.erb", layout: false
  end

  # 多选时移动分组
  def move
    @thumb_group_id = params[:thumb_group_id].presence
    @thumb_groups = @public_account.thumb_groups
    render "move.js.erb", layout: false
  end

  # 对单个图片移动分组
  def move_single
    @select_prev_link = params[:select_prev_link].presence
    @thumb_groups = @public_account.thumb_groups
    @ids = params[:ids]
    render "move_single.js.erb", layout: false
  end

  # 移动分组的动作
  def move_group
    @select_prev_link = params[:select_prev_link].presence
    @public_account.thumbs.where(id: params[:ids]).update_all(move_group_params)
    render "move_group.js.erb", layout: false
  end

  private

    def move_group_params
      params.permit(:thumb_group_id)
    end

    def upload_group_params
      params.permit(:thumb_group_id, :image)
    end

    def add_index_breadcrumb
      add_breadcrumb I18n.t("breadcrumbs.thumb.index"),
        public_account_thumbs_path(@public_account)
    end
end
