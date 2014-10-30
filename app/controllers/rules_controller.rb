class RulesController < SettingsController
  before_action :set_public_account, :add_show_breadcrumb
  def index
    @rules = @public_account.rules.includes(:kwords)
    @rules_count = @rules.count
    add_breadcrumb I18n.t('breadcrumbs.rule.index'), public_account_rules_path(@public_account)
  end

  def create
  end

  def update
  end

  def delete
  end

  def destroy
  end

  private
    def set_public_account
      @public_account = current_user.public_accounts.find(params[:public_account_id])
    end
    def add_show_breadcrumb
      add_breadcrumb @public_account.name, public_account_path(@public_account)
    end
end
