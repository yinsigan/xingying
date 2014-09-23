class AddDetailsToPublics < ActiveRecord::Migration
  def change
    add_index :publics, :user_id
    rename_column :publics, :type, :tp
  end
end
