class AddMaterialIdToKwords < ActiveRecord::Migration
  def change
    add_reference :kwords, :material_id, index: true
  end
end
