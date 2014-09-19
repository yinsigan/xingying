class AddUserIdToPublics < ActiveRecord::Migration
  def change
    add_column :publics, :user_id, :integer
  end
end
