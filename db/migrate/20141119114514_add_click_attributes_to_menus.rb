class AddClickAttributesToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :click_tp, :integer
    add_reference :menus, :material, index: true
  end
end
