class SinMaterialsController < SettingsController
  before_action :sin_material_params, only: [:create, :update]
  before_action :set_public_account
  before_action :add_material_breadcrumb
  before_action :find_sin_material, only: [:edit, :update, :destroy]

  def index
    @sin_materials = @public_account.sin_materials.includes(sin_pic_text: [:thumb]).page params[:page]
    store_location
  end

  def create
    @sin_material = @public_account.sin_materials.build(sin_material_params)
    if @sin_material.save
      save_article_address(@sin_material)
      redirect_via_turbolinks_to public_account_sin_materials_path(@public_account),
        flash: {success: I18n.t('success_submit')}
    else
      render partial: "shared/ajax_prompt.js.erb", layout: false, locals: {object: @sin_material}
    end
  end

  def new
    add_breadcrumb I18n.t('breadcrumbs.sin_material.new'),
      new_public_account_sin_material_path(@public_account)
    @sin_material = @public_account.sin_materials.build
    @sin_pic_text = @sin_material.build_sin_pic_text
  end

  def edit
    @sin_pic_text = @sin_material.sin_pic_text
    add_breadcrumb I18n.t('breadcrumbs.sin_material.edit'),
      edit_public_account_sin_material_path(@public_account, @sin_material)
    render "edit"
  end

  def update
    if @sin_material.update(sin_material_params)
      save_article_address(@sin_material)
      redirect_via_turbolinks_to public_account_sin_materials_path(@public_account),
        flash: {success: I18n.t('success_save')}
    else
      render partial: "shared/ajax_prompt.js.erb", layout: false, locals: {object: @sin_material}
    end
  end

  def delete
    render "shared/delete.js.erb", layout: false,
      locals: {delete_url: public_account_sin_material_path,
      confirm: I18n.t("sin_materials.delete.confirm"), remote: true}
  end

  def click_response
    if params[:sin_pic_text_id].present?
      @sin_pic_text = @public_account.sin_pic_texts.find(params[:sin_pic_text_id])
    end
    if params[:sin_material] && params[:sin_material][:sin_pic_text_attributes]
      render SinPicText::ClickResponseNode[params[:sin_material][:sin_pic_text_attributes][:click_response].to_i] + ".js.erb", layout: false
    end
  end

  def destroy
    @sin_material.destroy
    render "destroy.js.erb", layout: false
  end

  private

    def set_public_account
      @public_account = current_user.public_accounts.find(params[:public_account_id])
      set_page_title @public_account.name
    end

    def find_sin_material
      @sin_material = @public_account.sin_materials.find(params[:id])
    end

    def sin_material_params
      params.require(:sin_material).permit(
        :public_account_id,
        sin_pic_text_attributes: [:title,
                                  :desc,
                                  :body,
                                  :thumb_id,
                                  :click_response,
                                  :id,
                                  :article_address])
    end

    def add_material_breadcrumb
      add_breadcrumb I18n.t('breadcrumbs.material.pic_text'),
        public_account_sin_materials_path(@public_account)
    end

    def save_article_address(sin_material)
      if sin_material.sin_pic_text.click_response == 1 && sin_material.sin_pic_text.body.present?
        sin_material.save_article_address(article_url(sin_material.sin_pic_text.id))
      end
    end
end
