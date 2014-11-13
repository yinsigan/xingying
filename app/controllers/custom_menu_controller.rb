class CustomMenuController < SettingsController
  before_action :set_public_account, :add_show_breadcrumb

  def show_menu
  end

  private

  def set_public_account
    @public_account = current_user.public_accounts.find(params[:id])
    set_page_title @public_account.name
  end

  def add_show_breadcrumb
    add_breadcrumb @public_account.name, public_account_path(@public_account)
  end
end
