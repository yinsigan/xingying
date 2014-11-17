class Menu < ActiveRecord::Base
  belongs_to :public_account

  validates :name, presence: true, length: { maximum: 4 }

  acts_as_nested_set dependent: :destroy

  validate :menu_count_within_limit, :on => :create, if: "parent_id.nil?"

  private
  def menu_count_within_limit
    if self.public_account.menus(:reload).count >= 3
      errors.add(:base, "最多只能创建3个一级菜单")
    end
  end
end
