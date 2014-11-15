class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.string :key
      t.string :tp
      t.string :url
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.belongs_to :public_account, index: true

      t.timestamps
    end
  end
end
