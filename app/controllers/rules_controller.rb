class RulesController < SettingsController
  before_action :set_public_account, :add_show_breadcrumb
  def index
    add_breadcrumb I18n.t('breadcrumbs.rule.index'), public_account_rules_path(@public_account)
    @rules = @public_account.rules.includes(:kwords)
    @rules_count = @rules.count
    @rule = @public_account.rules.build
    [].tap { |k| 1.times { k << @rule.kwords.build } }
  end

  def create
    @rule = @public_account.rules.build(rule_params)
    if @rule.save
      redirect_to public_account_rules_path(@public_account), flash: {success: I18n.t('success_save')}
    else
      redirect_to public_account_rules_path(@public_account), flash: {success: @rule.errors.messages}
    end
  end

  def update
  end

  def delete
  end

  def destroy
  end

  def new_kword
    if params[:kword_hidden]
      @kword_hidden = params[:kword_hidden].to_i
    end
    render "new_kword.js.erb", layout: false
  end

  def edit_kword
    @kword_content = params[:kword_content]
    render "edit_kword.js.erb", layout: false
  end

  private
    def set_public_account
      @public_account = current_user.public_accounts.find(params[:public_account_id])
    end
    def add_show_breadcrumb
      add_breadcrumb @public_account.name, public_account_path(@public_account)
    end

    def rule_params
      params.require(:rule).permit(:public_account_id, :name, kwords_attributes: [:content, :subjectable_id, :public_account_id])
    end
end
