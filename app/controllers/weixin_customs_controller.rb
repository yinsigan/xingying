class WeixinCustomsController < SettingsController
  before_action :set_public_account, :appid_present
  def index
    add_breadcrumb I18n.t("breadcrumbs.weixin_custom.index"), :public_account_weixin_customs_path
  end
end
