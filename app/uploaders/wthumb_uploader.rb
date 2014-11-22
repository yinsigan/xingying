# encoding: utf-8
class WthumbUploader < CarrierWave::Uploader::Base


  include CarrierWave::MiniMagick

  storage :qiniu


  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :preview do
    process :resize_to_limit => [240, 240]
  end

end
