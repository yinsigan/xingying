class RulesController < SettingsController
  before_action :set_public_account
  before_action :find_rule, only: [:edit, :destroy, :update, :cancel]
  before_action :find_rule_id, only: [:new_kword, :edit_new_kword, :reply_content]

  def index
    add_breadcrumb I18n.t('breadcrumbs.rule.index'), public_account_rules_path(@public_account)
    @q = @public_account.rules.search(params[:q])
    @rules = @q.result.includes(:kwords).order("created_at DESC").page(params[:page]).uniq
    @rules_count = @rules.total_count

    # 创建新规则
    @rule = @public_account.rules.build
    session[:kword_index] = 0
    @rule.kwords.build if @rule.new_record?

    store_location

    if request.xhr?
      render "index.js.erb", layout: false
    end
  end

  def create
    @rule = @public_account.rules.build(rule_params)
    @flash_success = I18n.t('success_submit')
    @rule.save
    @object = @rule
    render partial: "shared/ajax_prompt.js.erb", layout: false
  end

  def update
    @flash_success = I18n.t('success_save')
    @rule.update(rule_params)
    @object = @rule
    render partial: "shared/ajax_prompt.js.erb"
  end

  def edit
    @kwords = @rule.kwords.order("created_at DESC")
    session[:edit_kword_index] = @kwords.count
    render "edit.js.erb", layout: false
  end

  def delete
    @delete_url = public_account_rule_path
    @confirm = I18n.t("rules.delete.confirm")
    @remote = true
    render "shared/delete.js.erb", layout: false
  end

  def destroy
    @rule.destroy
    render "shared/success_destroy.js.erb", layout: false
  end

  # 添加规则时添加新关键字
  def new_kword
    @kword_index = session[:kword_index] = session[:kword_index] + 1
    render "new_kword.js.erb", layout: false
  end

  # 编辑规则时添加新关键字
  def edit_new_kword
    @kword_index = session[:edit_kword_index] = session[:edit_kword_index] + 1
    render "new_kword.js.erb", layout: false
  end

  def cancel
    render "cancel.js.erb", layout: false
  end

  # 选择回复类型
  def reply_content
    @kword_object = @public_account.kwords.find(params[:kword_object]) if params[:kword_object].present?
    @kword_index = params[:kword_index]
    if params[:rule] && params[:rule][:kwords_attributes].values[0][:subjectable_type]
      render Kword::ReplyTypeNode[params[:rule][:kwords_attributes].values[0][:subjectable_type].to_s] + ".js.erb", layout: false
    end
  end

  private

    def rule_params
      params.require(:rule).permit(
        :public_account_id,
        :name,
        kwords_attributes:[:name,
                           :subjectable_id,
                           :public_account_id,
                           :subjectable_type,
                           :reply,
                           :id,
                           :_destroy])
    end

    def find_rule
      @rule = @public_account.rules.find(params[:id])
    end

    def find_rule_id
      @rule_id = params[:rule_id].presence
    end

end
