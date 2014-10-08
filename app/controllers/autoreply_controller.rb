class AutoreplyController < SettingsController
  before_action :add_show_breadcrumb
  def added
    add_breadcrumb I18n.t("breadcrumbs.autoreply.added"), added_public_account_path
    @public_account = PublicAccount.new
  end

  def default
  end

  def keyword
  end

  private
    def add_show_breadcrumb
      add_breadcrumb I18n.t("breadcrumbs.public_account.show"), :public_account_path
    end
end
