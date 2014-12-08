class ShopsController < ApplicationController
  layout :select_layout

  # 首页
  def index
  end

  # 商品展示
  def show
  end

  # 商品列表
  def list
  end

  # 商品搜索
  def search
  end

  # 购物车
  def shopping_cart
  end

  # 订单页面
  def orders
  end

  def user_center
  end

  private
    # 选择布局方法
    def select_layout
      case action_name
      when "index"
        "shops"
      else
        "goods"
      end
    end
end
