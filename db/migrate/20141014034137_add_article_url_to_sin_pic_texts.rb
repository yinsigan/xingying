class AddArticleUrlToSinPicTexts < ActiveRecord::Migration
  def change
    add_column :sin_pic_texts, :article_url, :string
  end
end
