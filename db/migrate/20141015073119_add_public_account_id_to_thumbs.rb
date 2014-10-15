class AddPublicAccountIdToThumbs < ActiveRecord::Migration
  def change
    add_reference :thumbs, :public_account, index: true
  end
end
