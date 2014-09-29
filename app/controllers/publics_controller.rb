class PublicsController < SettingsController
  before_action :set_public, only: [:show, :edit, :update, :destroy]
  before_action :add_index_breadcrumb

  # GET /publics
  # GET /publics.json
  def index
    @publics = current_user.publics
  end

  # GET /publics/1
  # GET /publics/1.json
  def show
    add_breadcrumb I18n.t("breadcrumbs.public.show"), :public_path
  end

  # GET /publics/new
  def new
    add_breadcrumb I18n.t("breadcrumbs.public.new"), :new_public_path
    @public = current_user.publics.build
  end

  # GET /publics/1/edit
  def edit
  end

  # POST /publics
  # POST /publics.json
  def create
    @public = current_user.publics.build(public_params)

    respond_to do |format|
      if @public.save
        format.html { redirect_to @public, flash: {success: "提交成功"} }
        format.json { render :show, status: :created, location: @public }
      else
        format.html { render :new }
        format.json { render json: @public.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publics/1
  # PATCH/PUT /publics/1.json
  def update
    respond_to do |format|
      if @public.update(public_params)
        format.html { redirect_to @public, flash: {success: "保存成功"}}
        format.json { render :show, status: :ok, location: @public }
      else
        format.html { render :edit }
        format.json { render json: @public.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publics/1
  # DELETE /publics/1.json
  def destroy
    @public.destroy
    respond_to do |format|
      format.html { redirect_to publics_url, flash: {success: "删除成功"} }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_public
      @public = current_user.publics.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def public_params
      params.require(:public).permit(:name, :password, :tp, :image)
    end

    def add_index_breadcrumb
      add_breadcrumb I18n.t("breadcrumbs.public.index"), :publics_path
    end
end
