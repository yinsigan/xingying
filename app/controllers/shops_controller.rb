class ShopsController < ApplicationController
  layout :select_layout
  def index

  end

  def show

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
