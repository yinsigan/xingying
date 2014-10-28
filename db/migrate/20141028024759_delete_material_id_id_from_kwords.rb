class DeleteMaterialIdIdFromKwords < ActiveRecord::Migration
  def change
    remove_column :kwords, :material_id_id
  end
end
