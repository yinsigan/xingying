class MenusController < SettingsController
  before_action :set_public_account
  before_action :appid_present, :add_show_breadcrumb
  before_action :set_menu, only: [:edit, :destroy, :update]

  def index
    @client ||= WeixinAuthorize::Client.new(@public_account.try(:appid), @public_account.try(:appsecret))
    if @client.is_valid?
      @menus = @public_account.menus.where(:parent => nil).includes(:children).order("id ASC")
    else
      store_location
    end
  end

  def new
    @parent_menu = params[:parent_menu].presence
    @new_title = params[:parent_menu].present? ? I18n.t("menus.index.new_sub_menu") : I18n.t("menus.index.new_top_menu")
    @name_maximum = params[:parent_menu].present? ? I18n.t("menus.form.sub_menu_name_maximum") : I18n.t("menus.form.top_menu_name_maximum")
    @menu = @public_account.menus.build
    render "new.js.erb", layout: false
  end

  def create
    @menu = @public_account.menus.build(menu_params)
    @menu.save
    render partial: "shared/ajax_prompt.js.erb", layout: false, locals: {object: @menu, flash_success: I18n.t("success_submit")}
  end

  def delete
    delete_info = params[:top_menu].present? ? I18n.t('menus.delete.top_menu') : I18n.t("menus.delete.sub_menu")
    render "shared/delete.js.erb", layout: false, locals: {
      delete_url: public_account_menu_path,
      confirm: delete_info,
      remote: true}
  end

  def edit
    @parent_menu = params[:parent_menu].presence
    @name_maximum = params[:top_menu].present? ? I18n.t("menus.form.top_menu_name_maximum") : I18n.t("menus.form.sub_menu_name_maximum")
    render "edit.js.erb", layout: false, name_maximum: @name_maximum
  end

  def destroy
    @menu.destroy
    render "shared/success_destroy.js.erb", layout: false
  end

  def update
    @menu.update(rename_params)
    render partial: "shared/ajax_prompt.js.erb", layout: false, locals: {object: @menu, flash_success: I18n.t("success_save")}
  end

  private

  def set_public_account
    @public_account = current_user.public_accounts.find(params[:public_account_id])
    set_page_title @public_account.name
  end

  def add_show_breadcrumb
    add_breadcrumb @public_account.name, public_account_path(@public_account)
  end

  def set_menu
    @menu = @public_account.menus.find(params[:id])
  end

  def appid_present
    if !(@public_account.appid.present? && @public_account.appsecret.present?)
      redirect_to edit_public_account_path(@public_account),
        flash: {danger: I18n.t("menus.index.enter_tip")}
      store_location
    end
  end

  def menu_params
    params.require(:menu).permit(:name, :parent_id)
  end

  def rename_params
    params.require(:menu).permit(:name)
  end
end