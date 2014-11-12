class ArticlesController < ApplicationController
  layout "article"
  def show
    @article = SinPicText.find(params[:id])
  end
end
