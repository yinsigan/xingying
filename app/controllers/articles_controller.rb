class ArticlesController < ApplicationController
  layout "article"
  def show
    @article = SinPicText.find(params[:id])
    set_page_title @article.title
    set_page_description @article.desc
  end
end