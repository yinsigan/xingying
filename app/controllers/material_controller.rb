class MaterialController < SettingsController
  before_action :pic_text_breadcrumb, only: [:pic_text, :sin_pic_text, :multi_pic_text]
  before_action :set_public_account

  def multi_pic_text
    add_breadcrumb I18n.t('breadcrumbs.material.multi_pic_text'), multi_pic_text_public_account_path(@public_account)
  end

  private
    def set_public_account
      @public_account = current_user.public_accounts.find(params[:id])
    end

    def pic_text_breadcrumb
      add_breadcrumb I18n.t('breadcrumbs.material.pic_text'), public_account_sin_materials_path
    end
end
