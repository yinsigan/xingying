class HomeController < ApplicationController
  def index
    set_page_title I18n.t('home')
  end
end
