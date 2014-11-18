class AddRgtIndexToMenus < ActiveRecord::Migration
  def change
    add_index :menus, :rgt
  end
end
