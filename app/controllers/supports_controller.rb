class SupportsController < ApplicationController
  before_action :find_all_category, only: [:index, :show]

  def index
    @support_category = params[:support_category_id].present? ? SupportCategory.find_by(id: params[:support_category_id]) : SupportCategory.first
    @supports = @support_category.supports.page(params[:page]) unless @support_category.blank?
  end

  def show
    @support = Support.find(params[:id])
  end

  private

  def find_all_category
    set_page_title I18n.t('seo.support.index')
    @support_categories = SupportCategory.all
  end
end
