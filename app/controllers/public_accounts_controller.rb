class PublicAccountsController < SettingsController
  before_action :set_public_account, only: [:show, :edit, :update, :destroy, :show_token]
  before_action :add_index_breadcrumb
  layout "not_show_pa", except: :show

  def index
    @public_accounts = current_user.public_accounts
    set_page_title I18n.t('seo.public_account.index')
  end

  def show
    add_breadcrumb @public_account.name, public_account_path(@public_account)
  end

  def new
    add_breadcrumb I18n.t("breadcrumbs.public_account.new"), :new_public_account_path
    set_page_title I18n.t('seo.public_account.new')
    @public_account = current_user.public_accounts.build
  end

  def edit
    add_breadcrumb I18n.t("breadcrumbs.public_account.edit"),
      edit_public_account_path(@public_account)
  end

  def create
    add_breadcrumb I18n.t("breadcrumbs.public_account.new"), :new_public_account_path
    @public_account = current_user.public_accounts.build(public_account_params)

    if @public_account.save
      redirect_to @public_account, flash: {success: I18n.t('success_submit')}
    else
      render :new
    end
  end

  def update
    if @public_account.update(public_account_params)
      flash[:success] = I18n.t('success_save')
      redirect_back_or @public_account
    else
      render :edit
    end
  end

  def delete
    @delete_url = public_account_path
    @confirm = I18n.t("public_accounts.delete.confirm")
    @remote = false
    render "shared/delete.js.erb", layout: false
  end

  def destroy
    @public_account.destroy
    redirect_to public_accounts_url, flash: {success: I18n.t('success_delete')}
  end

  def show_token
    render "show_token.js.erb", layout: false
  end

  private
    def set_public_account
      @public_account = current_user.public_accounts.find(params[:id])
      set_page_title @public_account.name
    end

    def public_account_params
      params.require(:public_account).permit(:name, :tp, :image, :appid, :appsecret)
    end

    def add_index_breadcrumb
      add_breadcrumb I18n.t("breadcrumbs.public_account.index"), :public_accounts_path
    end
end
