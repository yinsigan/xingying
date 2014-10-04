class AddUserIdToPublicAccounts < ActiveRecord::Migration
  def change
    add_column :public_accounts, :user_id, :integer
  end
end
