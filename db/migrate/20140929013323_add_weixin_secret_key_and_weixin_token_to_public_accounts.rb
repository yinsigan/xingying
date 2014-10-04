class AddWeixinSecretKeyAndWeixinTokenToPublicAccounts < ActiveRecord::Migration
  def change
    add_column :public_accounts, :weixin_secret_key, :string
    add_column :public_accounts, :weixin_token, :string
  end
end
