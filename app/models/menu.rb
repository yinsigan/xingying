class Menu < ActiveRecord::Base
  ClickType = {1 => "文字", 2 => "单图文"}
  ClickTypeNode = {1 => "text_material", 2 => "sin_material"}

  belongs_to :public_account
  belongs_to :sin_material, foreign_key: "material_id", class: SinMaterial

  validates :name, presence: true, length: { maximum: 4 }, if: Proc.new { |menu| menu.parent.depth.to_i == 0 }
  validates :name, presence: true, length: { maximum: 7 }, if: Proc.new { |menu| menu.parent.depth.to_i == 1 }
  validate :menu_count_within_limit, if: Proc.new { |menu| menu.parent.depth.to_i == 0 }, on: :create
  validate :sub_menu_count_within_limit, if: Proc.new { |menu| menu.parent.depth.to_i == 1 }, on: :create
  VALID_URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  validates :url, presence: true, format: { with: VALID_URL_REGEX }, if: "tp == 'view'"
  validates :click_body, allow_nil: true, length: { in: 1..600 }
  validates :sin_material, presence: true, if: "tp == 'click' && click_type == 2"
  validates :click_type, presence: true, if: "tp == 'click'"

  acts_as_nested_set dependent: :destroy

  def menu_count_within_limit
    if self.parent.children(:reload).count >= 3
      errors.add(:base, "最多只能创建3个一级菜单")
    end
  end

  def sub_menu_count_within_limit
    if self.parent.children(:reload).count >= 5
      errors.add(:base, "最多只能创建5个二级菜单")
    end
  end

  # 检查菜单是否设置好动作
  def check_set_action
    if self.root?
      self.root.descendants.select { |f| f.tp.nil? if f.children.empty? }.map(&:name)
    end
  end

  # 菜单启用的json参数
  def create_post_params
    if self.root?
      menu = {}
      menu[:button] = []
      self.root.children.includes(:children).each_with_index do |second_menu, second_menu_index|
        menu[:button][second_menu_index] = {}
        menu[:button][second_menu_index][:name] = second_menu.name
        if second_menu.children.empty?
          if second_menu.tp.present?
            menu[:button][second_menu_index][:type] = second_menu.tp
            if second_menu.tp == "view"
              menu[:button][second_menu_index][:url] = second_menu.url
            elsif second_menu.tp == "click"
              menu[:button][second_menu_index][:key] = second_menu.key
            end
          end
        else
          menu[:button][second_menu_index][:sub_button] = []
          second_menu.children.reverse_order.each_with_index do |third_menu, third_menu_index|
            menu[:button][second_menu_index][:sub_button][third_menu_index] = {}
            menu[:button][second_menu_index][:sub_button][third_menu_index][:type] = third_menu.tp
            menu[:button][second_menu_index][:sub_button][third_menu_index][:name] = third_menu.name
            if third_menu.tp == "view"
              menu[:button][second_menu_index][:sub_button][third_menu_index][:url] = third_menu.url
            elsif third_menu.tp == "click"
              menu[:button][second_menu_index][:sub_button][third_menu_index][:key] = third_menu.key
            end
          end
        end
      end
      menu
    end
  end
end
