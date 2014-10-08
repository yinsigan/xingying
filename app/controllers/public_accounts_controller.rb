class PublicAccountsController < SettingsController
  before_action :set_public_account, only: [:show, :edit, :update, :destroy]
  before_action :add_index_breadcrumb
  layout "not_show_pa", except: :show

  # GET /publics
  # GET /publics.json
  def index
    @public_accounts = current_user.public_accounts
  end

  # GET /publics/1
  # GET /publics/1.json
  def show
    add_breadcrumb I18n.t("breadcrumbs.public_account.show"), :public_account_path
  end

  # GET /publics/new
  def new
    add_breadcrumb I18n.t("breadcrumbs.public_account.new"), :new_public_account_path
    @public_account = current_user.public_accounts.build
  end

  # GET /publics/1/edit
  def edit
    add_breadcrumb I18n.t("breadcrumbs.public_account.edit"), :edit_public_account_path
  end

  # POST /publics
  # POST /publics.json
  def create
    add_breadcrumb I18n.t("breadcrumbs.public_account.edit"), :edit_public_account_path
    @public_account = current_user.public_accounts.build(public_account_params)

    respond_to do |format|
      if @public_account.save
        format.html { redirect_to @public_account, flash: {success: I18n.t('success_submit')} }
        format.json { render :show, status: :created, location: @public_account }
      else
        format.html { render :new }
        format.json { render json: @public_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publics/1
  # PATCH/PUT /publics/1.json
  def update
    respond_to do |format|
      if @public_account.update(public_account_params)
        format.html { redirect_to @public_account, flash: {success: I18n.t('success_save')}}
        format.json { render :show, status: :ok, location: @public_account }
      else
        format.html { render :edit }
        format.json { render json: @public_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publics/1
  # DELETE /publics/1.json
  def destroy
    @public_account.destroy
    respond_to do |format|
      format.html { redirect_to public_accounts_url, flash: {success: I18n.t('success_delete')} }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_public_account
      @public_account = current_user.public_accounts.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def public_account_params
      params.require(:public_account).permit(:name, :tp, :image)
    end

    def add_index_breadcrumb
      add_breadcrumb I18n.t("breadcrumbs.public_account.index"), :public_accounts_path
    end
end
