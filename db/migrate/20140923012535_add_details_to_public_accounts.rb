class AddDetailsToPublicAccounts < ActiveRecord::Migration
  def change
    add_index :public_accounts, :user_id
  end
end
