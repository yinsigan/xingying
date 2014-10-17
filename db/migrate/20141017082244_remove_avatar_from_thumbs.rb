class RemoveAvatarFromThumbs < ActiveRecord::Migration
  def change
    remove_column :thumbs, :avatar
  end
end
