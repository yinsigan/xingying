class AddImageToPublics < ActiveRecord::Migration
  def change
    add_column :publics, :image, :string
  end
end
