class ShopsController < ApplicationController
  layout :select_layout
  def index

  end

  def show

  end

  def list

  end

  def search

  end

  def shopping_cart

  end

  private
    def select_layout
      case action_name
      when "index"
        "shops"
      else ""
        "goods"
      end
    end
end
