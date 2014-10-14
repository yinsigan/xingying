class CreateSinPicTexts < ActiveRecord::Migration
  def change
    create_table :sin_pic_texts do |t|
      t.text :body
      t.belongs_to :thumb, index: true
      t.string :title
      t.text :desc
      t.belongs_to :sin_material, index: true
      t.belongs_to :multi_material, index: true

      t.timestamps
    end
  end
end
