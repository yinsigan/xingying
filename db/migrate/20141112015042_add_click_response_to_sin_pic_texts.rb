class AddClickResponseToSinPicTexts < ActiveRecord::Migration
  def change
    add_column :sin_pic_texts, :click_response, :integer, default: 1
  end
end