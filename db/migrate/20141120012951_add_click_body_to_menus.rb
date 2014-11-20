class AddClickBodyToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :click_body, :text
  end
end
