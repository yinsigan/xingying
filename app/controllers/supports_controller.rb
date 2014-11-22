class SupportsController < ApplicationController
  def index
    @support_categories = SupportCategory.all
    if params[:support_category_id]
      @support_category = SupportCategory.find(params[:support_category_id])
      @supports = @support_category.supports
    else
      @support_category = @support_categories.last
      @supports = @support_category.supports
    end
  end

  def show
    @support_categories = SupportCategory.all
    @support = Support.find(params[:id])
  end
end
