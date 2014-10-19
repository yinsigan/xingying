class AddPicUrlSinPicTexts < ActiveRecord::Migration
  def change
    add_column :sin_pic_texts, :pic_url, :string
  end
end
