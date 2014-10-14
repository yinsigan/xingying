class AddSinPicTextsCountToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :sin_pic_texts_count, :integer, default: 0
  end
end
