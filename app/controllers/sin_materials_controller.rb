class SinMaterialsController < SettingsController
  before_action :sin_material_params, only: [:create]
  before_action :set_public_account
  before_action :add_material_breadcrumb
  def create
    add_breadcrumb I18n.t('breadcrumbs.material.sin_pic_text'), new_public_account_sin_material_path(@public_account)
    @sin_material = @public_account.sin_materials.build(sin_material_params)
    if @sin_material.save
      redirect_to pic_text_public_account_path(@public_account), flash: {success: I18n.t('success_submit')}
    else
      render "new"
    end
  end

  def new
    add_breadcrumb I18n.t('breadcrumbs.material.sin_pic_text'), new_public_account_sin_material_path(@public_account)
    @sin_material = @public_account.sin_materials.build
    @sin_pic_text = @sin_material.build_sin_pic_text
  end

  def edit
    @sin_material = @public_account.sin_materials.find(params[:id])
    @sin_pic_text = @sin_material.sin_pic_text
    add_breadcrumb I18n.t('breadcrumbs.material.edit_sin_pic_text'), edit_public_account_sin_material_path(@public_account, @sin_material)
    render "edit"
  end

  def update
  end

  def delete
    render "delete.js.erb", layout: false
  end

  def destroy
    @sin_material = @public_account.sin_materials.find(params[:id])
    @sin_material.destroy
    redirect_to pic_text_public_account_path(@public_account), flash: {success: I18n.t('success_delete')}
  end

  private

    def set_public_account
      @public_account = current_user.public_accounts.find(params[:public_account_id])
    end

    def sin_material_params
      params.require(:sin_material).permit(:public_account_id, sin_pic_text_attributes: [:title, :desc, :body, :thumb_id])
    end

    def add_material_breadcrumb
      add_breadcrumb I18n.t('breadcrumbs.material.title'), pic_text_public_account_path(@public_account)
    end
end
