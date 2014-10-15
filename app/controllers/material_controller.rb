class MaterialController < SettingsController
  before_action :pic_text_breadcrumb, only: [:pic_text, :sin_pic_text, :multi_pic_text]
  before_action :set_public_account

  def pic_text
  end

  def sin_pic_text
    add_breadcrumb I18n.t('breadcrumbs.material.sin_pic_text'), sin_pic_text_public_account_path
    @sin_material = @public_account.sin_materials.build
    @sin_pic_text = @sin_material.build_sin_pic_text
  end

  def multi_pic_text
    add_breadcrumb I18n.t('breadcrumbs.material.multi_pic_text'), multi_pic_text_public_account_path
  end

  def picture
    add_breadcrumb I18n.t('breadcrumbs.material.picture'), picture_public_account_path
  end

  def audio
    add_breadcrumb I18n.t('breadcrumbs.material.audio'), audio_public_account_path
  end

  def video
    add_breadcrumb I18n.t('breadcrumbs.material.video'), video_public_account_path
  end

  private
    def set_public_account
      @public_account = current_user.public_accounts.find(params[:id])
    end

    def pic_text_breadcrumb
      add_breadcrumb I18n.t('breadcrumbs.material.pic_text'), pic_text_public_account_path
    end
end
