class AutoreplyController < SettingsController
  before_action :set_public_account, :add_show_breadcrumb
  def added
    add_breadcrumb I18n.t("breadcrumbs.autoreply.added"), added_public_account_path
  end

  def set_default_reply
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
    def set_public_account
      @public_account = current_user.public_accounts.find(params[:id])
    end

    def add_show_breadcrumb
      add_breadcrumb @public_account.name, :public_account_path
    end

    def public_account_params
      params.require(:public_account).permit(:default_reply)
    end
end
