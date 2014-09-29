class AddWeixinSecretKeyAndWeixinTokenToPublics < ActiveRecord::Migration
  def change
    add_column :publics, :weixin_secret_key, :string
    add_column :publics, :weixin_token, :string
  end
end
