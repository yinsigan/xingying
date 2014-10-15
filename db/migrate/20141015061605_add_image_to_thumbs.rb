class AddImageToThumbs < ActiveRecord::Migration
  def change
    add_column :thumbs, :image, :string
  end
end
