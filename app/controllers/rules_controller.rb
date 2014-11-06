class RulesController < SettingsController
  before_action :set_public_account, :add_show_breadcrumb
  before_action :find_rule, only: [:edit, :destroy, :update]
  def index
    add_breadcrumb I18n.t('breadcrumbs.rule.index'), public_account_rules_path(@public_account)
    @rules = @public_account.rules.includes(:kwords).order("created_at DESC").page(params[:page])
    @rules_count = @rules.total_count
    @rule = @public_account.rules.build
    session[:kword_index] = 0
    @rule.kwords.build if @rule.new_record?
  end

  def create
    @rule = @public_account.rules.build(rule_params)
    if @rule.save
      redirect_to public_account_rules_path(@public_account), flash: {success: I18n.t('success_save')}
    else
      add_breadcrumb I18n.t('breadcrumbs.rule.index'), public_account_rules_path(@public_account)
      @rules = @public_account.rules.includes(:kwords)
      @rules_count = @rules.count
      render :index
    end
  end

  def update
    if @rule.update(rule_params)
      redirect_to public_account_rules_path(@public_account), flash: {success: I18n.t('success_save')}
    else
      add_breadcrumb I18n.t('breadcrumbs.rule.index'), public_account_rules_path(@public_account)
      @rules = @public_account.rules.includes(:kwords)
      @rules_count = @rules.count
      render :index
    end
  end

  def edit
    @kwords = @rule.kwords.order("created_at DESC")
    render "edit.js.erb", layout: false
  end

  def delete
    render "shared/delete.js.erb", layout: false, locals: {delete_url: public_account_rule_path, confirm: I18n.t("rules.delete.confirm"), remote: false}
  end

  def destroy
    @rule.destroy
    redirect_to public_account_rules_path, flash: {success: I18n.t('success_delete')}
  end

  def new_kword
    @kword_index = session[:kword_index] = session[:kword_index] + 1
    render "new_kword.js.erb", layout: false
  end

  # 选择回复类型
  def reply_content
    # 标志id
    @edit = params[:edit] if params[:edit].present?
    @kword_object = @public_account.kwords.find(params[:kword_object]) if params[:kword_object].present?
    @kword_index = params[:kword_index]
    if params[:rule] && params[:rule][:kwords_attributes].values[0][:subjectable_type]
      render Kword::ReplyTypeNode[params[:rule][:kwords_attributes].values[0][:subjectable_type].to_s] + ".js.erb", layout: false
    end
  end

  private
    def set_public_account
      @public_account = current_user.public_accounts.find(params[:public_account_id])
    end
    def add_show_breadcrumb
      add_breadcrumb @public_account.name, public_account_path(@public_account)
    end

    def rule_params
      params.require(:rule).permit(:public_account_id, :name, kwords_attributes: [:content, :subjectable_id, :public_account_id, :subjectable_type, :reply, :id])
    end

    def find_rule
      @rule = @public_account.rules.find(params[:id])
    end

end
