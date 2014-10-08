class AutoreplyController < SettingsController
  before_action :add_show_breadcrumb
  def added
    add_breadcrumb I18n.t("breadcrumbs.autoreply.added"), added_public_account_path
    @public_account = current_user.public_accounts.find(params[:id])
  end

  def set_default_reply
    @public_account = current_user.public_accounts.find(params[:id])
    if  @public_account.update(public_account_params)
      flash.now[:success] = I18n.t('success_save')
    end
    render :added
  end

  def default
  end

  def keyword
  end

  private
    def add_show_breadcrumb
      add_breadcrumb I18n.t("breadcrumbs.public_account.show"), :public_account_path
    end

    def public_account_params
      params.require(:public_account).permit(:default_reply)
    end
end
