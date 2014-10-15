class SinMaterialsController < SettingsController
  before_action :sin_material_params
  before_action :set_public_account
  def create
    @sin_material = @public_account.sin_materials.build(sin_material_params)
    if @sin_material.save
      redirect_to pic_text_public_account_path(@public_account), flash: {success: I18n.t('success_submit')}
    else
    end
  end

  private

    def set_public_account
      @public_account = current_user.public_accounts.find(params[:public_account_id])
    end

    def sin_material_params
      params.require(:sin_material).permit(:public_account_id, sin_pic_text_attributes: [:title, :desc, :body])
    end
end
