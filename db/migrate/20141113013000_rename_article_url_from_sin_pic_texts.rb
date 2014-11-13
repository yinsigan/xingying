class RenameArticleUrlFromSinPicTexts < ActiveRecord::Migration
  def change
    rename_column :sin_pic_texts, :article_url, :article_address
  end
end
