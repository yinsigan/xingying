class AddImageToPublicAccounts < ActiveRecord::Migration
  def change
    add_column :public_accounts, :image, :string
  end
end
