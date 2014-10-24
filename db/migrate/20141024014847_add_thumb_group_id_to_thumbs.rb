class AddThumbGroupIdToThumbs < ActiveRecord::Migration
  def change
    add_reference :thumbs, :thumb_group, index: true
  end
end
