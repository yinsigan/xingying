class ChangePublics < ActiveRecord::Migration
  def change
    remove_column :publics, :password
  end
end
