class Menu < ActiveRecord::Base
  belongs_to :public_account

  validates :name, presence: true, length: { maximum: 4 }, if: "parent_id.nil?"
  validates :name, presence: true, length: { maximum: 7 }, unless: "parent_id.nil?"
  validate :menu_count_within_limit, if: "parent_id.nil?", on: :create
  validate :sub_menu_count_within_limit, unless: "parent_id.nil?", on: :create

  acts_as_nested_set dependent: :destroy

  private

  def menu_count_within_limit
    if self.public_account.menus(:reload).where(:parent => nil).count >= 3
      errors.add(:base, "最多只能创建3个一级菜单")
    end
  end

  def sub_menu_count_within_limit
    if self.parent.children(:reload).where("parent_id IS NOT NULL").count >= 5
      errors.add(:base, "最多只能创建5个二级菜单")
    end
  end
end