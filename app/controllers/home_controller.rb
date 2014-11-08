class HomeController < ApplicationController
  def index
    set_page_title I18n.t('home')
    # set_page_description @article.excerpt # or @article.content.truncate(100)
    # set_page_keywords    @article.tags    # or @article.keywords
  end
end
