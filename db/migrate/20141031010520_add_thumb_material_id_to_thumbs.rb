class AddThumbMaterialIdToThumbs < ActiveRecord::Migration
  def change
    add_reference :thumbs, :thumb_material, index: true
  end
end
