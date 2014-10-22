class AddFileSizeAndContentTypeAndFileNameToThumbs < ActiveRecord::Migration
  def change
    add_column :thumbs, :content_type, :string
    add_column :thumbs, :file_size, :string
    add_column :thumbs, :file_name, :string
  end
end
