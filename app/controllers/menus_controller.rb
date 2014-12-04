class MenusController < SettingsController
  before_action :set_public_account
  before_action :appid_present, :add_show_breadcrumb
  before_action :set_menu, only: [:edit, :destroy, :update,
                                  :send_message, :redirect_url, :set_action,
                                  :click_content, :move_left, :move_right]
  before_action :find_root_menu, only: [:index, :publish_menu, :check_publish_menu]

  def index
    store_location
    add_breadcrumb I18n.t("breadcrumbs.menu.index"), :public_account_menus_path
    @menus = @root_menu.children.includes(:children).order("id ASC")
  end

  def new
    @parent_menu = params[:parent_menu].presence
    @title = params[:depth].present? && params[:depth].to_i == 1 ? I18n.t("menus.index.new_sub_menu") : I18n.t("menus.index.new_top_menu")
    @name_maximum = params[:depth].present? && params[:depth].to_i == 1 ? I18n.t("menus.form.sub_menu_name_maximum") : I18n.t("menus.form.top_menu_name_maximum")
    @menu = @public_account.menus.build
    render "new.js.erb", layout: false
  end

  def create
    @menu = @public_account.menus.build(menu_params)
    @flash_success = I18n.t("success_submit")
    @menu.save
    @object = @menu
    render partial: "shared/ajax_prompt.js.erb", layout: false
  end

  def delete
    @confirm = params[:top_menu].present? ? I18n.t('menus.delete.top_menu') : I18n.t("menus.delete.sub_menu")
    @delete_url = public_account_menu_path
    @remote = true
    render "shared/delete.js.erb", layout: false
  end

  def edit
    @parent_menu = params[:parent_menu].presence
    @title = I18n.t('menus.menu.rename')
    @name_maximum = params[:top_menu].present? ? I18n.t("menus.form.top_menu_name_maximum") : I18n.t("menus.form.sub_menu_name_maximum")
    render "edit.js.erb", layout: false
  end

  def destroy
    @menu.destroy
    render "shared/success_destroy.js.erb", layout: false
  end

  def update
    @flash_success = I18n.t("success_save")
    @menu.update(update_params)
    @object = @menu
    render partial: "shared/ajax_prompt.js.erb", layout: false
  end

  def send_message
    @selected_sin_material = @public_account.sin_materials.find(params[:select_sin_id]) if params[:select_sin_id].present?
    render "send_message.js.erb", layout: false
  end

  def redirect_url
    render "redirect_url.js.erb", layout: false
  end

  def set_action
    @menu_id = params[:id].presence
    render "set_action.js.erb", layout: false
  end

  def click_content
    if params[:menu] && params[:menu][:click_type]
      render Menu::ClickTypeNode[params[:menu][:click_type].to_i] + ".js.erb", layout: false
    end
  end

  def move_left
    @menu.move_left
    render "move.js.erb", layout: false
  end

  def move_right
    @menu.move_right
    render "move.js.erb", layout: false
  end

  # 检查菜单是否设置动作
  def check_publish_menu
    @check_result = @root_menu.check_set_action
    render "check_publish_menu.js.erb", layout: false
  end

  # 启用并发布
  def publish_menu
    @client ||= WeixinAuthorize::Client.new(@public_account.appid, @public_account.appsecret, @public_account.id)
    if @client.is_valid?
      request_menu_result(@client.create_menu(@root_menu.create_post_params))
    else
      @error = true
      @flash = t("menus.check_publish_menu.access_token_error", public_account_id: @public_account.id)
    end
    render "publish_menu.js.erb", layout: false
  end

  def check_clear_menu
    render "check_clear_menu.js.erb", layout: false
  end

  # 停用并清除菜单
  def clear_menu
    @client ||= WeixinAuthorize::Client.new(@public_account.appid, @public_account.appsecret, @public_account.id)
    if @client.is_valid?
      request_menu_result @client.delete_menu
    else
      @error = true
      @flash = t("menus.check_publish_menu.access_token_error", public_account_id: @public_account.id)
    end
    render "publish_menu.js.erb", layout: false
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

  def update_params
    params.require(:menu).permit(:name, :url, :tp, :click_type, :click_body, :material_id, :key)
  end

  def find_root_menu
    @root_menu = @public_account.menus.where(:parent => nil).first
  end

  def request_menu_result(result)
    if result.is_ok?
      @flash = t('menus.check_publish_menu.success_request')
    else
      @error = true
      @flash = result.full_error_message
    end
  end
end
