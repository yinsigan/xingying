class AddClickAttributesToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :click_type, :integer, :default => 1
    add_reference :menus, :material, index: true
  end
end
