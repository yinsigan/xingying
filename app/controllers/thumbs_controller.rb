class ThumbsController < SettingsController
  skip_before_action :verify_authenticity_token
  before_action :set_public_account
  before_action :add_index_breadcrumb, only: [:index]
  def create
    @thumb = @public_account.thumbs.build
    @thumb.image = params[:image]
    @thumb.save
    render "create.js.erb", layout: false
  end

  def index
    @thumbs = @public_account.thumbs.page(params[:page]).per(12)
    @thumb_group = @public_account.thumb_groups.build
    @thumb_groups = @public_account.thumb_groups
  end

  def delete
    render "shared/delete.js.erb", layout: false, locals: {delete_url: public_account_thumb_path, confirm: I18n.t('thumbs.delete.confirm')}
  end

  def destroy
    @thumb = @public_account.thumbs.find(params[:id])
    @thumb.destroy
    redirect_to public_account_thumbs_path(@public_account), flash: {success: I18n.t('success_delete')}
  end

  def delete_all
    render "shared/delete_all.js.erb", layout: false, locals: {delete_url: destroy_all_public_account_thumbs_path(@public_account), confirm: I18n.t('thumbs.delete_all.confirm')}
  end

  def destroy_all
    @public_account.thumbs.where(id: params[:ids]).destroy_all
    redirect_via_turbolinks_to public_account_thumbs_path(@public_account), flash: {success: I18n.t('success_delete')}
  end

  def upload
    @thumb = @public_account.thumbs.new
    @thumb.image = params[:image]
    @thumb.save
    render "upload.js.erb", layout: false
  end

  private
    def set_public_account
      @public_account = current_user.public_accounts.find(params[:public_account_id])
    end

    def add_index_breadcrumb
      add_breadcrumb I18n.t("breadcrumbs.thumb.index"), public_account_thumbs_path(@public_account)
    end
end
